# BigQuery SQL Portfolio: Austin 311 Service Requests Analysis

## 📌 Project Overview
This repository contains SQL queries written in **Google BigQuery** to analyze public datasets. The primary focus of this project is exploring the **Austin 311 Service Requests** dataset to extract actionable insights regarding city operations and citizen complaints.

---

## 📂 Dataset Information
* **Platform:** Google BigQuery Public Datasets
* **Dataset:** `bigquery-public-data.austin_311.311_service_requests`
* **Description:** Contains records of service requests and complaints made to the Austin 311 city services.

---

## 🔍 Queries & Analysis

### 1. Top 10 Service Complaints (`top_10_complaints.sql`)
* **Objective:** Find the most frequent types of complaints/service requests submitted by citizens.
* **SQL Query:**
```sql
SELECT complaint_description, COUNT(complaint_description) as total_request
FROM `bigquery-public-data.austin_311.311_service_requests`
GROUP BY complaint_description
ORDER BY total_request DESC
LIMIT 10



