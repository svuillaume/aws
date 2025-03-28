#!/bin/bash

if [ "$#" -lt 4 ]; then
  echo "Usage: $0 <count> <instance_label> <ami> <instance_type>"
  exit 1
fi

# Assign the arguments to variables
count=$1
instance_label=$2
ami=$3
instance_type=$4

# Loop to create instances one by one
for i in $(seq 1 "$count"); do
  aws ec2 run-instances \
      --region ca-central-1 \
      --image-id "$ami" \
      --count 1 \
      --instance-type "$instance_type" \
      --key-name sam_aws.key \
      --security-group-ids sg-05290e55bbba0cc05 \
      --subnet-id subnet-0b5023aa808b86454 \
      --associate-public-ip-address \
      --user-data file://user-data.json \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_label-$i}]"

  echo "Instance $instance_label-$i launched."
done

