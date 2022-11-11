#IGNORE := $(shell bash -c "source .env; env | sed 's/=/:=/' | sed 's/^/export /' > /tmp/makeenv")
#include /tmp/makeenv  

export AWS_PROFILE=tw-beach

set-env:
	cp secrets/tw.env .env

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
	@eval `cat .env` && saml2aws login \
		--idp-account=$${IDP_ACCOUNT} \
		--region $${AWS_REGION} \
		--username=$${OKTA_USER} \
		--profile=$${AWS_PROFILE}
