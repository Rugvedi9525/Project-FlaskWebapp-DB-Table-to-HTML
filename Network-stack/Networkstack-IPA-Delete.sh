#!/bin/bash
echo "DELETING STACK"
stackName=Network-stack

aws cloudformation delete-stack --stack-name $stackName

aws cloudformation wait stack-delete-complete --stack-name $stackName


echo "STACK TERMINATED SUCCESSFULLY"