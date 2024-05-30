SELECT        esr.encounter_id, esr.id AS encounter_service_request_id, sr.name AS service_request_name, esr.note, srs.name AS service_request_status_name, esrs.created_at, esrs.updated_at
FROM            [StgPanda].[ventiemr].[encounter_service_request] AS esr LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[service_request] AS sr ON esr.service_request_id = sr.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[encounter_service_request_status] AS esrs ON esr.id = esrs.encounter_service_request_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[service_request_status] AS srs ON esrs.service_request_status_id = srs.id
where  esr.encounter_id IN(

    SELECT distinct  esr.encounter_id FROM  [StgPanda].[ventiemr].[encounter_service_request]
WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
)



MERGE INTO [StgPanda].[ventiemr].[service_request_status_summary] AS TARGET
USING [StgPanda].[ventiemr].[service_request_status_summary_temp] AS SOURCE 
ON (TARGET.updated_at = SOURCE.updated_at AND  TARGET.encounter_id = SOURCE.encounter_id AND TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id) 
WHEN MATCHED AND 
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.created_at <> SOURCE.created_at
         OR TARGET.updated_at <> SOURCE.updated_at
         OR TARGET.encounter_service_request_id <> SOURCE.encounter_service_request_id
         OR TARGET.service_request_name <> SOURCE.service_request_name
         OR TARGET.note <> SOURCE.note
         OR TARGET.service_request_status_name <> SOURCE.service_request_status_name
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.created_at = SOURCE.created_at,
		TARGET.updated_at = SOURCE.updated_at,
        TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id,
        TARGET.service_request_name = SOURCE.service_request_name,
        TARGET.note = SOURCE.note,
		TARGET.service_request_status_name = SOURCE.service_request_status_name
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, created_at,updated_at,
        encounter_service_request_id,
        service_request_name,note,service_request_status_name
    )          
    VALUES (
        SOURCE.encounter_id,SOURCE.created_at, SOURCE.updated_at,
        SOURCE.encounter_service_request_id,
        SOURCE.service_request_name, SOURCE.note,SOURCE.service_request_status_name
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;