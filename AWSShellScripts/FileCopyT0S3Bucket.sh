#!/bin/bash

SOURCE_FILE="/home/ec2-user"
AMAZON_S3_BUCKET="s3://bucket_name"   
if [[ -f "/home/ec2-user/filename" ]]
then
	$aws s3 cp ${SOURCE_FILE} ${AMAZON_S3_BUCKET}
fi
