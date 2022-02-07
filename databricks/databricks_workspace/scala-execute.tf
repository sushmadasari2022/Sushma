
data "template_file" "script" {
  template = "${file("onboard.scala")}"

  vars {
    os_tenant_name       = "${var.tenant_name}"
    os_username          = "${ovh_publiccloud_user.spark_job.username}"
    os_password          = "${ovh_publiccloud_user.spark_job.password}"
    os_region            = "${var.region}"
    swift_container_name = "${openstack_objectstorage_object_v1.dataset.container_name}"
    swift_object_name    = "${openstack_objectstorage_object_v1.dataset.name}"
  }
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    master_instance_id  = "${module.databricks_cluster.master_instance_id}"
    slaves_instance_ids = "${join(",", module.spark_cluster.slaves_instance_ids)}"
    script              = "${data.template_file.spark_script.rendered}"
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host                = "${module.databricks_cluster.master_ipv4_addr}"
    user                = "ubuntu"
    private_key         = "${file("~/.ssh/id_rsa")}"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "${data.template_file.spark_script.rendered}"
    destination = "/tmp/spark-script.scala"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    inline = ["cat /tmp/spark-script.scala | spark-shell --packages org.apache.hadoop:hadoop-openstack:2.7.4"]
  }
}