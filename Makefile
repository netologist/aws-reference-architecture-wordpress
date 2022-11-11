source .env
export AWS_PROFILE=tw-beach

set-env:
	cp secrets/tw.env .env

config:
	saml2aws configure \
		--idp-account ${IDP_ACCOUNT} \
		--idp-provider Okta \
		--mfa TOTP \
		--username ${OKTA_USER} \
		--url ${OKTA_URL} \
		--role ${AWS_ROLE} \
		--credentials-file=${CREDENTIAL_FILE} \
		--cache-saml \
		--skip-prompt

login:
	saml2aws login \
		--idp-account=${IDP_ACCOUNT} \
		--region ${AWS_REGION} \
		--username=${OKTA_USER} \
		--profile=${AWS_PROFILE}
