from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime

with DAG(
    dag_id="from_s3_metadata",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    tags=["snowflake"],
) as dag:

    create_table_raw_cn = SQLExecuteQueryOperator(
        task_id="create_table_raw_cn",
        sql="sql/raw_cn.sql",
        conn_id="snowflake_conn",
    )

    create_table_raw_iso_codes = SQLExecuteQueryOperator(
        task_id="create_table_raw_iso_codes",
        sql="sql/raw_iso_codes.sql",
        conn_id="snowflake_conn",
    )

    create_table_raw_cn >> create_table_raw_iso_codes