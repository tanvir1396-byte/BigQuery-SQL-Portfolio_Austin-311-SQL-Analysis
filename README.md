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
### 5.latest_complaints_by_type.sql
* **objective:** Find the 3 most recent service requests for each complaint description based on the creation date using window functions (ROW_NUMBER() or RANK()) and the QUALIFY clause.
* **SQL Query:**
```sql
SELECT complaint_description,created_date,
ROW_NUMBER() OVER (partition by complaint_description ORDER BY created_date DESC)as row_list
FROM `bigquery-public-data.austin_311.311_service_requests`

QUALIFY row_list<=3
ORDER BY complaint_description,row_list
```

### 6.lag_analysis_by_zip.sql
* **objective:** Analyze the time gap between consecutive service requests for each zip code by retrieving the previous request's creation date using the LAG() window function.
* **SQL Query:**
```sql
SELECT incident_zip, created_date as current_date,
LAG(created_date) OVER ( partition by incident_zip  ORDER BY created_date )as previous_date

FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip IS NOT NULL;
```
### 7.merge_austin_data.sql
* **objective:** Synchronize the target table (austin_service_target) with the source table (311_service_requests) by updating existing records where keys match and inserting new records when they do not match using the MERGE statement.
* **SQL Query:**
```sql
MERGE INTO `elite-vista-474514-t0.my_first_dataset.austin_service_target` as target
USING `bigquery-public-data.austin_311.311_service_requests` as source
ON target.unique_key=source.unique_key

WHEN MATCHED THEN
UPDATE SET target.complaint_description=source.complaint_description,
target.created_date=source.created_date

WHEN NOT MATCHED THEN
INSERT  (unique_key,complaint_description,created_date)
VALUES (source.unique_key, source.complaint_description, source.created_date)
```


