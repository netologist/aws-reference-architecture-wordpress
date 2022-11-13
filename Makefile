ROOT_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
export AWS_PROFILE=tw-beach

install-deps:
	@${ROOT_DIR}/scripts/install-dependencies.sh

set-env:
	@cp ${ROOT_DIR}/secrets/tw.env ${ROOT_DIR}/.env

bootstrap-remote-state:
	@${ROOT_DIR}/scripts/bootstrap-remote-state.sh install

config: 
	@eval `cat .env` && saml2aws configure \
		--idp-account $${IDP_ACCOUNT} \
		--idp-provider Okta \
		--mfa TOTP \
		--username $${OKTA_USER} \
		--url $${OKTA_URL} \
		--role $${AWS_ROLE} \
		--credentials-file=$${CREDENTIAL_FILE} \
		--cache-saml \
		--skip-prompt

login:
	@${ROOT_DIR}/scripts/aws-login.sh

fmt:
	terraform fmt --recursive ${ROOT_DIR}


plan:
	@echo "you should in terraform or terragrunt directories"

deploy: plan
	terraform apply