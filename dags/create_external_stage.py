from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime

with DAG(
    dag_id="create_external_stage",
    start_date=datetime(2025, 1, 1),
    schedule=None,
    catchup=False,
    tags=["snowflake"],
) as dag:

    s3_trhs_external_stage = SQLExecuteQueryOperator(
        task_id="s3_trhs_external_stage",
        sql="sql/s3_trhs_external_stage.sql",
        conn_id="snowflake_conn",
    )

    s3_metadata_external_stage = SQLExecuteQueryOperator(
        task_id="s3_metadata_external_stage",
        sql="sql/s3_metadata_external_stage.sql",
        conn_id="snowflake_conn",
    )
    s3_trhs_external_stage >> s3_metadata_external_stage