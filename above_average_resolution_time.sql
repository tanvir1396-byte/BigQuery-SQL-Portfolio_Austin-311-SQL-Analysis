SELECT complaint_description
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE TIMESTAMP_DIFF(close_date, created_date, HOUR)>

(SELECT AVG(TIMESTAMP_DIFF(close_date, created_date, HOUR)) as avg_time
FROM `bigquery-public-data.austin_311.311_service_requests`
)
