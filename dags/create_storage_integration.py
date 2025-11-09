from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime

with DAG(
    dag_id="create_s3_storage_integration",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    tags=["snowflake"],
) as dag:

    create_s3_storage_integration = SQLExecuteQueryOperator(
        task_id="create_s3_storage_integration",
        sql="sql/s3_storage_integration.sql",
        conn_id="snowflake_conn",
    )

    create_s3_storage_integration