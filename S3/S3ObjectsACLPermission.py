#!/usr/bin/python3.7
import boto3
s3 = boto3.resource('s3')
bucket = s3.Bucket('nwaytech')
for obj in bucket.objects.all():
    key = obj.key
    acl = obj.Acl()
    for grant in acl.grants:
        if grant['Grantee']['Type'].lower() == 'group' and grant['Grantee']['URI'] == 'http://acs.amazonaws.com/groups/global/AllUsers':
           grant_permission = grant['Permission'].lower()
           if grant_permission == 'read':
                print('Public Access:Read,nwaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'write':
                print('Public Access:write,nwaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'read_acp':
                print('Public Access:Read_ACP,nwaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'write_acp':
                print('Public Access:Write_ACP,nwaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'full_control':
                print('Public Access: Full Control,nwaytech.s3-ap-southeast-1.amazonaws.com/'+key)

For Specific subfolder in S3 Bucket and Put ACL Permission to private

#!/usr/bin/python3.7
import boto3
s3 = boto3.resource('s3')
bucket = s3.Bucket('testnewaytech')
for obj in bucket.objects.filter(Prefix="Pdf"):
    key = obj.key
    acl = obj.Acl()
    for grant in acl.grants:
        if grant['Grantee']['Type'].lower() == 'group' and grant['Grantee']['URI'] == 'http://acs.amazonaws.com/groups/global/AllUsers':
           grant_permission = grant['Permission'].lower()
           if grant_permission == 'read':
                response=acl.put(ACL='private')
                print('Public Access:Read,testnewaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'write':
                response=acl.put(ACL='private')
                print('Public Access:write,testnewaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'read_acp':
                response=acl.put(ACL='private')
                print('Public Access:Read_ACP,testnewaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'write_acp':
                response=acl.put(ACL='private')
                print('Public Access:Write_ACP,testnewaytech.s3-ap-southeast-1.amazonaws.com/'+key)
           elif grant_permission == 'full_control':
                response=acl.put(ACL='private')
                print('Public Access: Full Control,testnewaytech.s3-ap-southeast-1.amazonaws.com/'+key)   
