#!/bin/sh

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

export $(grep -v '^#' $DIR/../.env | xargs)

saml2aws login \
    --idp-account=${IDP_ACCOUNT} \
    --region ${AWS_REGION} \
    --username=${OKTA_USER} \
    --profile=${AWS_PROFILE}
