#!/bin/sh

cd $(dirname $0)/../terraform

TF_CLI_CONFIG_FILE=../secrets/terraformrc \
  AWS_SHARED_CREDENTIALS_FILE=../secrets/aws_credentials \
  terraform $@
