#!/bin/bash

# Extract instance IDs containing 'i-' from ec2_list and save them to ec2_to_terminate
awk '/i-/ {for (i=1; i<=NF; i++) if ($i ~ /^i-/) print $i}' ec2_list > ec2_to_terminate

# Display the extracted instance IDs
echo "The following instance IDs were found:"
cat ec2_to_terminate

# Ask for confirmation to proceed
read -p "Do you want to terminate these instances? (yes/no): " confirm

if [[ "$confirm" == "yes" ]]; then
    # Loop through each instance ID in ec2_to_terminate and terminate the instances
    while read instance_id; do
        echo "Terminating instance: $instance_id"
        aws ec2 terminate-instances --region ca-central-1 --instance-ids "$instance_id"
    done < ec2_to_terminate
else
    echo "Operation cancelled."
fi

