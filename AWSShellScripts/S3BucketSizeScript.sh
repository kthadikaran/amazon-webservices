#!/usr/bin/bash
for dir in $(aws s3 ls  | awk '{print $3'});
do
    size=$(aws s3 ls s3://${dir} --recursive  | grep -v -E "(Bucket: |Prefix: |LastWriteTime|^$|--)" | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}');
    echo "${dir}  $size" | tee -a disk.txt
done
