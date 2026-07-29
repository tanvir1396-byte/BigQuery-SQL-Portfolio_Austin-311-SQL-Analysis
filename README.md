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
LIMIT 10;
```


### 2. austin_311_zip_filter.sql
* **Objective:** Find the most frequent complaints/service requests in a specific zip code (78704) where the total count is greater than 50.
* **SQL Query:**
```sql
SELECT incident_zip,complaint_description, COUNT(complaint_description) as total_count
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip='78704'
GROUP BY incident_zip, complaint_description
HAVING COUNT(complaint_description)>50;
```

### 3.above_average_resolution_time.sql
* **objective:** Find the complaints where the resolution time (duration between creation and closing) is greater than the overall average resolution time.
* **SQL Query:**
```sql
SELECT complaint_description
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE TIMESTAMP_DIFF(close_date, created_date, HOUR)>

(SELECT AVG(TIMESTAMP_DIFF(close_date, created_date, HOUR)) as avg_time
FROM `bigquery-public-data.austin_311.311_service_requests`
);
```
### 4.top_busiest_zip_codes.sql
* **objective:** Find the top 5 busiest zip codes based on the total number of service requests using a Common Table Expression (CTE).
* **SQL Query:**
```sql
WITH newtable as (SELECT incident_zip, COUNT(complaint_description) as total_complain,
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip IS NOT NULL
GROUP BY incident_zip)

SELECT incident_zip,total_complain
FROM newtable
ORDER BY total_complain DESC
LIMIT 5;
```

