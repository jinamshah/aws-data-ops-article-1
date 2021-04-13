import boto3

s3_bucket = '<YOUR_BUCKET>'
s3_prefix = '<PATH TO YOUR S3 FOLDER>'

s3_client = boto3.client('s3')


def get_s3_objects(s3, **base_kwargs):
    continuation_token = None
    while True:
        list_kwargs = dict(MaxKeys=1000, **base_kwargs)
        if continuation_token:
            list_kwargs['ContinuationToken'] = continuation_token
        response = s3.list_objects_v2(**list_kwargs)
        yield from response.get('Contents', [])
        if not response.get('IsTruncated'):
            break
        continuation_token = response.get('NextContinuationToken')


def lambda_handler(event, context):
    data_size = 0
    for file in get_s3_objects(boto3.client('s3'), Bucket=s3_bucket,
                               Prefix=s3_prefix):
        data_size += file['Size']

    size_per_server_in_gb = (data_size / 1e+9) * 2  # assuming the process needs twice the storage as raw data

    return {'ebs_size': size_per_server_in_gb}
