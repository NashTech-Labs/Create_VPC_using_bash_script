#!/bin/bash

# creating variables for VPC creation
REGION=<your_aws_region> # eg:'ap-south-1'
VPC_TAG_NAME=<your_vpc_tag_name> # eg: 'aws_Cli_VPC_tagName'
VPC_CIDR_BLOCK=<your_vpc_cidr_block> # eg:'10.1.0.0/16'


# VPC creating message
echo "Creating VPC..."

# creating vpc and storing response
awsResponse=$(aws ec2 create-vpc \
            --cidr-block "$VPC_CIDR_BLOCK" \
            --region "$REGION" \
            --output json)

# getting vpcId
vpcId=$(echo -e "$awsResponse" | \
        /usr/bin/jq '.Vpc.VpcId' | \
        tr -d '"')
sleep 2

# tagging vpc
echo "Tagging vpc..."
aws ec2 create-tags \
        --resources "$vpcId" \
        --tags Key=Name,Value="$VPC_TAG_NAME" \
        --region "$REGION"

# describe vpcId
echo "VPC description:"
vpcDescription=$(aws ec2 describe-vpcs \
                --vpc-ids "$vpcId" \
                --region "$REGION")

echo $vpcDescription | /usr/bin/jq