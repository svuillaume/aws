#!/bin/bash

# Define the AWS region
REGION="ca-central-1"

# Describe instances, display the output as a table, and save it to a file
aws ec2 describe-instances \
    --region "$REGION" \
    --filters "Name=tag:Name,Values=samv-*" \
    --query "Reservations[].Instances[].{InstanceID:InstanceId,Name:Tags[?Key=='Name'].Value|[0],State:State.Name,DNS:PublicDnsName}" \
    --output table | tee ec2_list

echo "The EC2 instance details have been saved to ec2_list."

