set:
	terraform init
	terraform validate
plan:
	terraform plan -var "databricks_account_username=XXXXX" -var "databricks_account_password=XXXXX" -var "databricks_account_id=XXXXX" -var "aws_access_key=$AWS_ACCESS_KEY_ID" -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" -var "aws_token"=$AWS_SESSION_TOKEN  -var="region=$AWS_DEFAULT_REGION" -out=plan.out

apply:
	terraform apply plan.out -var "databricks_account_username=XXXXX" -var "databricks_account_password=XXXXX" -var "databricks_account_id=XXXXX" -var "aws_access_key=$AWS_ACCESS_KEY_ID" -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" -var "aws_token"=$AWS_SESSION_TOKEN  -var="region=$AWS_DEFAULT_REGION"  
	
destroy:
	terraform destroy -var "databricks_account_username=XXXXX" -var "databricks_account_password=XXXXX" -var "databricks_account_id=XXXXX" -var "aws_access_key=$AWS_ACCESS_KEY_ID" -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" -var "aws_token"=$AWS_SESSION_TOKEN  -var="region=$AWS_DEFAULT_REGION" 
