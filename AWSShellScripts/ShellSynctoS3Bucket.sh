#!/bin/bash
aws_profile=my-s3
backup_path=/home/me/backup
bucket_name=my-backup
aws s3 sync $backup_path s3://$bucket_name --storage-class=STANDARD_IA --profile=$aws_profile


#tar -cvzf ${BACKUP_DIR}/backup-files-${NOW}.tar.gz ${FOLDERS_TO_BACKUP[@]}
