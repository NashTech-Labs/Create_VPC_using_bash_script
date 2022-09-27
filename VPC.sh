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

# getting vpc_id
vpc_id=$(echo -e "$awsResponse" | \
		/usr/bin/jq '.Vpc.VpcId' | \
		tr -d '"')
sleep 2

# tagging vpc
echo "Tagging vpc..."
aws ec2 create-tags \
		--resources "$vpc_id" \
		--tags Key=Name,Value="$VPC_TAG_NAME" \
        --region "$REGION"

# describe vpc_id
echo "VPC description:"
vpc_descrition=$(aws ec2 describe-vpcs \
        --vpc-ids "$vpc_id" \
        --region "$REGION")

echo $vpc_descrition | /usr/bin/jq