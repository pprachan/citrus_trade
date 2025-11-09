FROM python:3.11-slim

WORKDIR /opt/airflow/dbt

RUN pip install --no-cache-dir dbt-snowflake

COPY dbt/packages.yml ./

EXPOSE 5050