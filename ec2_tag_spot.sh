#!/bin/bash


yum install -y jq

tag_key=myKey
tag_value=myValue
instance_name=MySpotInstance

region=`curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region`
instanceId=`curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .instanceId`
echo $instanceId

ebsVolId=`aws ec2 describe-instances --instance-ids $instanceId --query 'Reservations[].Instances[].BlockDeviceMappings[].Ebs[].VolumeId' --region $region --output text`

echo $ebsVolId

echo "Creating EC2 instance name tag..."
aws ec2 create-tags --resources $instanceId --tags Key=Name,Value=$instance_name --region $region 2>&1


echo "Applying tags to EBS volumes..."
for i in $ebsVolId
do aws ec2 create-tags --resources $i --tags Key=$tag_key,Value=$tag_value --region $region 2>&1
done

echo "User-data script complete"
