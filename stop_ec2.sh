#!/bin/bash

# Define the AWS region and VPC ID
REGION="ca-central-1"
VPC_ID="vpc-01da516c539120c66"

# Get the list of running EC2 instances in the specified VPC
INSTANCE_IDS=$(aws ec2 describe-instances \
    --region "$REGION" \
    --filters "Name=vpc-id,Values=$VPC_ID" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

# Check if any instances are found
if [ -z "$INSTANCE_IDS" ]; then
    echo "No running EC2 instances found in VPC $VPC_ID."
    exit 0
fi

# Stop all instances in a single command
echo "Stopping the following EC2 instances in VPC $VPC_ID: $INSTANCE_IDS"
aws ec2 stop-instances --region "$REGION" --instance-ids $INSTANCE_IDS

