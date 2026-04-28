# 📊 Strategic Marketing Analytics: End-to-End DBT Pipeline

An enterprise-grade data transformation layer built with **dbt (Data Build Tool)** and **Google BigQuery**, designed to turn fragmented marketing data into high-integrity business intelligence.

---

## 💎 Business Value Proposition (Non-Technical)
In today’s data-driven landscape, marketing performance visibility is often hindered by "data silos." This pipeline solves that by:
* **Unified Performance Reporting:** Consolidates metrics from multiple sources (e.g., Google Ads, Meta Ads) into a single "Source of Truth".
* **Data Integrity Assurance:** Implements automated quality checks to ensure that reporting used for budget allocation is 100% accurate.
* **Reduced Time-to-Insight:** Streamlines the path from raw data collection to executive-ready dashboards.
* **Cost-Efficient Scaling:** Leverages BigQuery’s serverless architecture to ensure high performance without massive infrastructure overhead.

---

## 🛠 Technical Architecture (Developer-Focused)
This project follows the **Medallion Architecture**, ensuring modularity and clean data lineage.

### **1. Data Modeling Layers**
* **Staging Layer (Bronze):** Raw source data is cleaned, cast, and renamed for consistency.
* **Intermediate Layer (Silver):** Complex business logic, cross-platform unions, and sessionization are handled here.
* **Marts Layer (Gold):** Final, highly-denormalized tables optimized for BI tools like Looker, Tableau, or PowerBI.

### **2. Technology Stack**
* **Core Engine:** dbt-core v1.7.0.
* **Warehouse:** Google BigQuery.
* **Environment:** Dockerized environment for consistent local and production execution.
* **Orchestration Ready:** Pre-configured for CI/CD via GitHub Actions with dedicated `prod` profiles.

---

## 🚀 Deployment & Operations

### **Prerequisites**
* **Docker Desktop** installed.
* **GCP Service Account Key:** Place your service account JSON in the root directory and name it `gckey.json`.

### **Setup Instructions**
1.  **Initialize Environment:**
    ```bash
    docker-compose up -d
    ```
    *This builds the dbt environment and mounts your local code into the container for real-time development.*

2.  **Access the Pipeline:**
    ```bash
    docker exec -it dbt_container bash
    ```

3.  **Execute the Workflow:**
    ```bash
    dbt deps    # Install framework extensions (dbt-utils)
    dbt run     # Materialize models in BigQuery
    dbt test    # Execute data quality audits
    ```

---

## 🛡 Data Quality & Governance
To maintain high data standards, the pipeline utilizes the `dbt-utils` package for advanced validation.
* **Integrity Tests:** Unique and Not-Null constraints prevent data duplication and missing metrics.
* **Schema Validation:** Ensures the warehouse structure matches the defined business documentation.
* **Documentation:** Auto-generated documentation (via `dbt docs`) provides a visual lineage of how every metric is calculated.

---

## 📈 Project Configuration Summary
* **Project Name:** `marketing_dbt_pipeline`.
* **Warehouse Target:** `marketing-dbt-pipeline` (BigQuery).
* **Production Dataset:** `dbt_analytics`.
* **Default Region:** `US`.

---
*Developed for professional marketing analytics environments.*
