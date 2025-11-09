resource "snowflake_file_format" "csv_comma_format" {
  name        = "CSV_COMMA_FORMAT"
  database    = "TRADE_FLOW"
  schema      = "RAW"
  format_type = "CSV"
  field_delimiter            = ","
  skip_header                = 1
  null_if                    = ["NULL", "null"]
  empty_field_as_null        = true
  field_optionally_enclosed_by = "\""
  compression                = "AUTO"
  depends_on = [snowflake_schema.raw_schema] 
}

resource "snowflake_file_format" "csv_semicolon_format" {
  name        = "CSV_SEMICOLON_FORMAT"
  database    = "TRADE_FLOW"
  schema      = "RAW"
  format_type = "CSV"
  field_delimiter            = ";"
  skip_header                = 1
  null_if                    = ["NULL", "null"]
  empty_field_as_null        = true
  field_optionally_enclosed_by = "\""
  compression                = "AUTO"
  depends_on = [snowflake_schema.raw_schema] 
}

resource "snowflake_file_format" "parquet_format" {
  name        = "PARQUET_FORMAT"
  database    = "TRADE_FLOW"
  schema      = "RAW"
  format_type = "PARQUET"
  compression = "AUTO"
  binary_as_text = false
  depends_on = [snowflake_schema.raw_schema] 
}