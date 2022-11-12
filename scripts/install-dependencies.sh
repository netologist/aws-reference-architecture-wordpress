#!/bin/sh

if ! command -v saml2aws &> /dev/null
then
    echo "saml2aws could not be found"

    CURRENT_VERSION=$(curl -Ls https://api.github.com/repos/Versent/saml2aws/releases/latest | grep 'tag_name' | cut -d'v' -f2 | cut -d'"' -f1)
    sudo mkdir /opt/saml2aws && sudo chown $(whoami) /opt/saml2aws
    wget -c https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz -O - | tar -xzv -C /opt/saml2aws
    chmod u+x /opt/saml2aws/saml2aws
    sudo ln -s /opt/saml2aws/saml2aws /usr/local/bin/saml2aws
    hash -r
    saml2aws --version
    eval "$(saml2aws --completion-script-zsh)"
fi


if ! command -v terraform &> /dev/null
then
    echo "terraform could not be found"
    sudo pacman -Syu --noconfirm terraform
fi


if ! command -v terragrunt &> /dev/null
then
    echo "terragrunt could not be found"
    sudo pacman -Syu --noconfirm terragrunt
fi
