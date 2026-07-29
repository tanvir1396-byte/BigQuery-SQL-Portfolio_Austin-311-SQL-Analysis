WITH newtable as (SELECT incident_zip, COUNT(complaint_description) as total_complain,
FROM `bigquery-public-data.austin_311.311_service_requests`
WHERE incident_zip IS NOT NULL
GROUP BY incident_zip)

SELECT incident_zip,total_complain
FROM newtable
ORDER BY total_complain DESC
LIMIT 5;

