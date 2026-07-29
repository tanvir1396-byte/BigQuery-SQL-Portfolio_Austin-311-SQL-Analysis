SELECT incident_zip,complaint_description, COUNT(complaint_description) as total_count
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip='78704'
GROUP BY incident_zip, complaint_description
HAVING COUNT(complaint_description)>50;
