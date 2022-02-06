#!/usr/bin/env bash
set -euo pipefail

# Based on https://askubuntu.com/a/983352

TERRAFORM_VERSION="0.13.4"

wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
mv terraform $HOME/.local/bin/terraform
rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
terraform --version
