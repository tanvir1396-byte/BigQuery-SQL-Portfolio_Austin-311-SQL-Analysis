MERGE INTO `elite-vista-474514-t0.my_first_dataset.austin_service_target` as target
USING `bigquery-public-data.austin_311.311_service_requests` as source
ON target.unique_key=source.unique_key

WHEN MATCHED THEN
UPDATE SET target.complaint_description=source.complaint_description,
target.created_date=source.created_date

WHEN NOT MATCHED THEN
INSERT  (unique_key,complaint_description,created_date)
VALUES (source.unique_key, source.complaint_description, source.created_date)
