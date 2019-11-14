#!/bin/bash
echo "CREATING STACK"
stackName=Network-stack

ipa_const=IPA

vpc_const=-VPC

ig_const=-IGW
natg_cont=-NATG
public_route_table_const=-PublicRouteTable
private_route_table_const=-PrivateRouteTable

public_subnet_tag=-PublicSubnet

private_subnet_tag=-PrivateSubnet
webServerSecurity_Tag=-WebServerSG
dbSecurityGroup_Tag=-DbServerSG

codedeploy_filepath=$1

stackId=$(aws cloudformation create-stack --stack-name $stackName --template-body \
 file://Networkstack-IPA-Create.json --parameters \
ParameterKey=vpcTag,ParameterValue=$ipa_const$vpc_const \
ParameterKey=publicSubnetTag,ParameterValue=$ipa_const$public_subnet_tag \
ParameterKey=privateSubnetTag,ParameterValue=$ipa_const$private_subnet_tag \
ParameterKey=igTag,ParameterValue=$ipa_const$ig_const \
ParameterKey=publicRouteTableTag,ParameterValue=$ipa_const$public_route_table_const \
ParameterKey=privateRouteTableTag,ParameterValue=$ipa_const$private_route_table_const \
ParameterKey=natgTag,ParameterValue=$ipa_const$natg_cont \
ParameterKey=webServerSecurityGroupNameTag,ParameterValue=$ipa_const$webServerSecurity_Tag \
ParameterKey=dbSecurityGroupNameTag,ParameterValue=$ipa_const$dbSecurityGroup_Tag \
--on-failure DELETE --query StackId --output text)

echo "#############################"
echo $stackId
echo "#############################"

if [ -z $stackId ]; then
    echo 'Error occurred.Dont proceed. TERMINATED'
else
    aws cloudformation wait stack-create-complete --stack-name $stackId
    echo 'STACK Creation Completed'
fi
echo "Pushing revision to the s3 bucket"
aws s3api put-object --bucket ipa-s3 --key codedeploy.zip --body $codedeploy_filepath