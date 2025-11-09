create or replace stage trade_flow.raw.s3_metadata_external_stage
    url = 's3://pprachan-eraneos-data/raw/metadata/'
    storage_integration = s3_storage_integration
    file_format = (format_name = 'trade_flow.raw.csv_comma_format');
