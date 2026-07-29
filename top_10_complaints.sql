SELECT complaint_description, COUNT(complaint_description) as total_request
FROM `bigquery-public-data.austin_311.311_service_requests`
GROUP BY complaint_description
ORDER BY total_request DESC
LIMIT 10
