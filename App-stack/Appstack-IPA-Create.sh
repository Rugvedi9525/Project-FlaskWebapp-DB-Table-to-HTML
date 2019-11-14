#!/bin/bash
stack_name=Application-stack
idRsa=$1

echo $stack_name

stackId=$(aws cloudformation create-stack --stack-name $stack_name --template-body \
 file://Appstack-IPA-Create.json --parameters \
  ParameterKey=keyTag,ParameterValue=$idRsa --query [StackId] --output text\
  --capabilities CAPABILITY_IAM)


echo "#############################"
echo $stackId
echo "#############################"

if [ -z $stackId ]; then
    echo 'Error occurred.Dont proceed. TERMINATED'
else
    aws cloudformation wait stack-create-complete --stack-name $stack_name
    echo "STACK CREATION COMPLETE."
fi


