create or replace stage trade_flow.raw.s3_trhs_external_stage
    url = 's3://pprachan-eraneos-data/trhs_citrus_parquet/'
    storage_integration = s3_storage_integration
    file_format = (format_name = 'trade_flow.raw.parquet_format')