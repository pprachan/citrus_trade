# dbt-terraform.Dockerfile
FROM python:3.12-slim

# Set Terraform version
ARG TERRAFORM_VERSION=1.13.4

# Install system dependencies + Terraform
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/terraform \
    && rm terraform.zip

# Install dbt (core + Snowflake adapter)
RUN pip install --no-cache-dir \
    dbt-core \
    dbt-snowflake
    
# Set working directory
WORKDIR /opt/airflow

# Copy only when needed (your compose mounts the full project)
COPY dbt/ ./dbt
COPY terraform/ ./terraform

# Default command keeps container alive for interactive use
CMD ["tail", "-f", "/dev/null"]
