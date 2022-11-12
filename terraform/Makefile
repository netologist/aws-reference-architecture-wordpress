include ../Makefile

plan:
	terraform init -backend-config="key=dev/terraform.tfstate" && \
	terraform workspace select dev || terraform workspace new dev && \
	terraform plan -var-file=dev.tfvars -out tfplan

destroy:
	terraform destroy -var-file=dev.tfvars