SELECT complaint_description,created_date,
ROW_NUMBER() OVER (partition by complaint_description ORDER BY created_date DESC)as row_list
FROM `bigquery-public-data.austin_311.311_service_requests`

QUALIFY row_list<=3
ORDER BY complaint_description,row_list

