#!/bin/bash 

set -e 

# echo "Will apply in this AWS account:"
# aws sts get-caller-identity

# So we can time this work 
BEGIN=$(date +%s)

# Get my IP 
ip=$(curl --silent checkip.amazonaws.com)

# Replace my IP in the security group rules 
sed -i "s/[0-9]\{2,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}/$ip/" multi-arch-tester.tf

# BUT... need to stop after the first match. Need to find a way around this.

# Apply terraform 
# terraform apply --auto-approve

# Timing
echo ""
echo "Finished in $(($(date +%s)-$BEGIN))s"