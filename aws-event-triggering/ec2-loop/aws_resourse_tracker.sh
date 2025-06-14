#!/bin/bash


#######################

# Author: Ak

# Date: 13th- June

# Version: v1

# This script will report the AWS resource usage

#######################


set -x

# AWS S3
# AWS EC2
# AWS LAMBDA
# AWS IAM

# list s3 buckets
echo "Print list of s3 buckets"
aws s3 ls > resourceTracker

# list ec2 instances
echo "Print list of ec2 instances"
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'

# list Lambda 
echo "Print list of lambda"
aws lambda list-functions >> resourceTracker:q!

# list IAM users
echo "Print list of IAM users"
aws iam list-users 
