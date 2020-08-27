#The following should work to trigger a Glue job from AWS Lambda. Have the lambda configured to the appropriate S3 bucket, 
#and IAM roles / permissions assigned to AWS Lambda so that lambda can start the AWS Glue job on behalf of the user.
import boto3
print('Loading function')

def lambda_handler(event, context):
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    s3 = boto3.client('s3')
    glue = boto3.client('glue')
    gluejobname = "YOUR GLUE JOB NAME"

    try:
        runId = glue.start_job_run(JobName=gluejobname)
        status = glue.get_job_run(JobName=gluejobname, RunId=runId['JobRunId'])
        print("Job Status : ", status['JobRun']['JobRunState'])
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist '
              'and your bucket is in the same region as this '
              'function.'.format(source_bucket, source_bucket))
    raise e
