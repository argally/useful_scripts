#!/bin/bash

# This script generates AWS Programmatic Access credentials from a user authenticated via SSO
# Before using, make sure that the AWS SSO is configured in your CLI: `aws configure sso`
# The Role ARN can be found in the AWS Console -> IAM -> Roles or via AWS CLI -> `aws iam list-roles`

profile="xxxxx"
role_arn="arn:aws:iam::xxxxxxx:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_xxxxxxxx"
user_name=$(echo $USER)

request_credentials() {
  credentials=$(
    aws sts assume-role \
      --profile $profile \
      --role-arn $role_arn \
      --role-session-name $user_name
  )
}
request_credentials

if [ $? -ne 0 ]; then
  aws sso login --profile "$profile"

  if [ $? -ne 0 ]; then
    exit 1
  fi

  request_credentials
fi

access_key_id=$(echo $credentials | perl -n -e'/"AccessKeyId": "([^,]+)"/ && print $1')
secret_key_id=$(echo $credentials | perl -n -e'/"SecretAccessKey": "([^,]+)"/ && print $1')
session_token=$(echo $credentials | perl -n -e'/"SessionToken": "([^,]+)"/ && print $1')

aws configure set --profile "$profile" aws_access_key_id "$access_key_id"
aws configure set --profile "$profile" aws_secret_access_key "$secret_key_id"
aws configure set --profile "$profile" aws_session_token "$session_token"
