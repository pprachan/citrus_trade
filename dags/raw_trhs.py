from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime

with DAG(
    dag_id="from_s3_trhs",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    tags=["snowflake"],
) as dag:

    raw_trhs = SQLExecuteQueryOperator(
        task_id="raw_trhs",
        sql="sql/raw_trhs.sql",
        conn_id="snowflake_conn",
    )

    raw_trhs