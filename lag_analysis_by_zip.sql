SELECT incident_zip, created_date as current_date,
LAG(created_date) OVER ( partition by incident_zip  ORDER BY created_date )as previous_date

FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip IS NOT NULL;
