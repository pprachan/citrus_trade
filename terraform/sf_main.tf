# --- Resources to Provision ---

# 1. Dedicated Database
resource "snowflake_database" "trade_flow" {
  name    = "TRADE_FLOW"
  comment = "Database containing international trade flow using the harmonized system (HS)."
}

# 2. Raw Schema
resource "snowflake_schema" "raw_schema" {
  database    = snowflake_database.trade_flow.name
  name        = "RAW"
  comment     = "Schema to hold data loaded from S3."
  is_managed  = false
}

# 3. Staging Schema
resource "snowflake_schema" "staging_schema" {
  database    = snowflake_database.trade_flow.name
  name        = "STAGING"
  comment     = "Schema to hold data loaded from S3."
  is_managed  = false
}

# 4. Marts Schema
resource "snowflake_schema" "marts_schema" {
  database    = snowflake_database.trade_flow.name
  name        = "MARTS"
  comment     = "Models containing joins, aggregations, complex logic."
  is_managed  = false
}

# 5. Analytics Schema
resource "snowflake_schema" "analytics_schema" {
  database    = snowflake_database.trade_flow.name
  name        = "ANALYTICS"
  comment     = "Table to be consume for visualisation"
  is_managed  = false
}

# Output the created names for reference
output "db_name" {
  value = snowflake_database.trade_flow.name
}

