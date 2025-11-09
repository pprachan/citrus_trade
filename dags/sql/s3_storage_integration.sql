create storage integration if not exists s3_storage_integration
    type = external_stage
    storage_provider = s3
    enabled = true
    storage_aws_role_arn = 'arn:aws:iam::543376453199:role/SnowflakeS3AccessRole'
    storage_allowed_locations = ('s3://pprachan-eraneos-data/');
