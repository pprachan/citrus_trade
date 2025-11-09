# 🍊 Modern Data Stack — Citrus Trade Pipeline

This project implements a **fully containerized data pipeline** orchestrating the flow of international citrus trade data from raw files in S3 to analytical insights in **Looker Studio**, powered by **Snowflake**, **dbt**, **Airflow**, and **Terraform**.

---

## 🧩 Architecture Overview

![Architecture Diagram](./docs/architecture.png)

### Key Components

| Layer | Technology | Purpose |
|--------|-------------|----------|
| **Storage** | **AWS S3** | Stores raw CSV and transformed Parquet files |
| **Exploration** | **Databricks** | Used for data exploration and parquet conversion |
| **Orchestration** | **Airflow** | Automates file ingestion and table creation |
| **Infrastructure** | **Terraform** | Provisions Snowflake databases, schemas, roles, and file formats |
| **Transformation** | **dbt Core** | Models and transforms data inside Snowflake |
| **Documentation** | **dbt Docs** | Generates model documentation and lineage graphs |
| **Visualization** | **Looker Studio** | Connects directly to Snowflake for BI and dashboards |
| **Containerization** | **Docker Compose** | Manages isolated local environments for Airflow, dbt, and Terraform |

---

## ⚙️ Data Flow

1. **Raw Data Upload**  
   - CSV files are stored in an **S3 bucket** under `/raw/`.
   - Databricks optionally explores and exports curated **Parquet files**.

2. **Infrastructure Provisioning (Terraform)**  
   - Creates Snowflake objects:
     - Database: `TRADE_FLOW`
     - Schemas: `RAW`, `STAGING`, `MARTS`, `ANALYTICS`
     - Roles and Users: `DBT_USER`, `AIRFLOW_USER`, `LOOKER_USER`, `ANALYST_USER`
     - File formats (`CSV_COMMA_FORMAT`, `PARQUET_FORMAT`)
     - External stages pointing to S3

3. **Ingestion (Airflow)**  
   - Airflow DAGs execute SQL scripts that:
     - Create external stages
     - Load data into Snowflake tables using `COPY INTO`
     - Trigger downstream dbt transformations

4. **Transformation (dbt)**  
   - dbt models transform raw Snowflake tables into clean, analytics-ready tables.
   - Follows the **staging → marts → analytics** convention.
   - dbt Docs provides full lineage and model documentation.

5. **Visualization (Looker Studio)**  
   - Connects directly to Snowflake for BI dashboards, exposing key trade metrics.

---

### Quick Start

```bash
# 1. Build the Docker images
docker compose build

# 2. Start all containers (Airflow, dbt, Terraform)
docker compose up -d

# 3. Initialize Airflow metadata
docker compose run --rm airflow-init

# 4. Open Airflow UI
open http://localhost:8080

#7. Open another terminal and enter dbt-terraform for Terraform 
docker exec -it citrus_trade_airflow-dbt-terraform bash 
# Then
cd .. 
cd terraform 
terraform init
terraform plan -out=citrus_trade.tfplan
terraform apply citrus_trade.tfplan

# 5. Enter the dbt-terraform container for dbt 
docker exec -it citrus_trade_airflow-dbt-terraform bash 

#6. The container is by default in the dbt folder, usual dbt commands can be used
dbt run

