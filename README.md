# 🍊 Modern Data Stack — Citrus Trade Pipeline

This project implements a **fully containerized data pipeline** orchestrating the flow of international citrus trade data from raw files in S3 to analytical insights in **Looker Studio**, powered by **Snowflake**, **dbt**, **Airflow**, and **Terraform**.

---

## 🧩 Architecture Overview

![Architecture Diagram](./docs/architecture.png)
[Architecture Diagram on Miro](https://miro.com/app/board/uXjVJtzeRYA=/?share_link_id=475327142809)

### Key Components

| Layer | Technology | Purpose |
|--------|-------------|----------|
| **Storage** | **AWS S3** | Stores raw CSV and transformed Parquet files |
| **Exploration** | **Databricks** | Used for data exploration and parquet conversion |
| **Orchestration** | **Airflow** | File ingestion and table creation in RAW schema |
| **Infrastructure** | **Terraform** | Provisions Snowflake databases, schemas, roles, and file formats |
| **Transformation** | **dbt Core** | Models and transforms data inside Snowflake |
| **Documentation** | **dbt Docs** | Generates model documentation and lineage graphs |
| **Visualization** | **Looker Studio** | Connects directly to Snowflake for BI and dashboards |
| **Containerization** | **Docker Compose** | Manages isolated local environments for Airflow, dbt, and Terraform |

---

## ⚙️ Data Flow

0. **AWS S3**  
   - Metadata are stored at `s3://pprachan-eraneos-data/raw/metadata/`.
   - Flow trade are stored at `s3://pprachan-eraneos-data/trhs_citrus_parquet/`.

1. **Infrastructure Provisioning (Terraform)**  
   - Creates Snowflake objects:
     - Database: `TRADE_FLOW`
     - Schemas: `RAW`, `STAGING`, `MARTS`, `ANALYTICS`
     - Roles and Users: `DBT_USER`, `AIRFLOW_USER`, `LOOKER_USER`, `ANALYST_USER`
     - File formats (`CSV_COMMA_FORMAT`, `PARQUET_FORMAT`)
     - External stages pointing to S3

2. **Ingestion (Airflow)**  
   - Airflow DAGs execute SQL scripts that:
     - Create storage integration 
     - Create external stages
     - Load data into Snowflake tables in the `RAW` schema using `COPY INTO`

3. **Transformation (dbt)**  
   - dbt models transform raw Snowflake tables into clean, analytics-ready tables.
   - Follows the **staging → marts → analytics** convention.
   - dbt Docs provides full lineage and model documentation.

4. **Visualization (Looker Studio)**  
   - Connects directly to Snowflake for BI dashboards, exposing key trade metrics.

Notes:
* The original data is uploaded manually to AWS S3
* DBT is decoupled from Airflow (we could use Cosmos or DBT Cloud in a production setting)
---

### Quick Start

```bash
# 1. Build the Docker images
docker compose build

# 2. Initialize Airflow metadata
docker compose run --rm airflow-init

# 3. Start all containers (Airflow, dbt, Terraform)
docker compose up -d

# 4. Open Airflow UI
open http://localhost:8080

# 5. Enter dbt-terraform for Terraform 
docker exec -it citrus_trade_airflow-dbt-terraform bash 
# Init Terraform before plan and apply
cd terraform 
terraform init
terraform plan -out=citrus_trade.tfplan
terraform apply citrus_trade.tfplan

# 6. Enter the dbt-terraform container for dbt 
docker exec -it citrus_trade_airflow-dbt-terraform bash 
cd dbt
dbt deps
dbt run

# 7. Open dbt-docs
open http://localhost:5050