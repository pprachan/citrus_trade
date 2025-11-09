resource "snowflake_user" "dbt_user" {
    name = "DBT_USER"
    default_warehouse = "COMPUTE_WH"
    default_role = "SYSADMIN"
    must_change_password = false
    comment = "Service user for dbt Core"
    lifecycle {
        ignore_changes = [default_secondary_roles]
    }
}

resource "snowflake_user" "airflow_user" {
    name = "AIRFLOW_USER"
    default_warehouse = "COMPUTE_WH"
    default_role = "SYSADMIN"
    must_change_password = false
    comment = "Service user for Airflow"
    lifecycle {
        ignore_changes = [default_secondary_roles]
    }
}

resource "snowflake_user" "looker_user" {
    name = "LOOKER_USER"
    default_warehouse = "COMPUTE_WH"
    default_role = "SYSADMIN"
    must_change_password = false
    comment = "Service user for Looker Studio"
    lifecycle {
        ignore_changes = [default_secondary_roles]
    }
}

# Create role and user for analyst 
resource "snowflake_role" "analyst_role" {
    name = "ANALYST_ROLE"
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_db" {
    privileges        = ["USAGE"]
    account_role_name = snowflake_role.analyst_role.name
    on_account_object {
        object_type = "DATABASE"
        object_name = snowflake_database.trade_flow.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_schema" {
    privileges        = ["USAGE"]
    account_role_name = snowflake_role.analyst_role.name
    on_schema {
        all_schemas_in_database = snowflake_database.trade_flow.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_select_tables" {
  privileges        = ["SELECT", "INSERT"]
  account_role_name = snowflake_role.analyst_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.trade_flow.name
    }
  }
}

resource "snowflake_user" "analyst_user" {
    name = "ANALYST_USER"
    default_warehouse = "COMPUTE_WH"
    default_role = "ANALYST_ROLE"
    must_change_password = false
    comment = "User with Analyst role with only read privileges to trade_flow database"
    lifecycle {
        ignore_changes = [default_secondary_roles]
    }
}