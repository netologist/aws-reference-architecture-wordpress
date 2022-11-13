include ../Makefile

plan:
	terraform init && \
	terraform workspace select dev || terraform workspace new dev && \
	terraform plan

destroy:
	terraform destroy -var-file=dev.tfvars