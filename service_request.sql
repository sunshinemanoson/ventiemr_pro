SELECT        ep.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, esr.id AS encounter_service_request_id, sr.name AS service_request_name, esr.note, 
                         srs.name AS encounter_service_request_current_status_name, esr.created_at, esr.updated_at
FROM            [StgPanda].[ventiemr].[encounter_procedure] AS ep LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[procedure_category] AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[procedure_status] AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[encounter_service_request] AS esr ON ep.based_on = esr.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[service_request] AS sr ON esr.service_request_id = sr.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[service_request_status] AS srs ON esr.current_status_id = srs.id
where  ep.encounter_id IN(

    SELECT distinct  ep.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
 WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
)


more test turning
MERGE INTO [StgPanda].[ventiemr].[service_request_summary] AS TARGET
USING [StgPanda].[ventiemr].[service_request_summary_temp] AS SOURCE 
ON (TARGET.updated_at = SOURCE.updated_at AND TARGET.encounter_id = SOURCE.encounter_id AND TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id) 
WHEN MATCHED AND 
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.created_at <> SOURCE.created_at
         OR TARGET.updated_at <> SOURCE.updated_at
         OR TARGET.procedure_category_name <> SOURCE.procedure_category_name
         OR TARGET.procedure_status_name <> SOURCE.procedure_status_name
         OR TARGET.encounter_service_request_id <> SOURCE.encounter_service_request_id
         OR TARGET.service_request_name <> SOURCE.service_request_name
         OR TARGET.note <> SOURCE.note
         OR TARGET.encounter_service_request_current_status_name <> SOURCE.encounter_service_request_current_status_name
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.created_at = SOURCE.created_at,
		TARGET.updated_at = SOURCE.updated_at,
        TARGET.procedure_category_name = SOURCE.procedure_category_name,
        TARGET.procedure_status_name = SOURCE.procedure_status_name,
        TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id,
        TARGET.service_request_name = SOURCE.service_request_name,
        TARGET.note = SOURCE.note,
		TARGET.encounter_service_request_current_status_name = SOURCE.encounter_service_request_current_status_name
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, created_at,updated_at,
        procedure_category_name,procedure_status_name,encounter_service_request_id,
        service_request_name,note,encounter_service_request_current_status_name
    )          
    VALUES (
        SOURCE.encounter_id,SOURCE.created_at, SOURCE.updated_at,
        SOURCE.procedure_category_name,SOURCE.procedure_status_name,SOURCE.encounter_service_request_id,
        SOURCE.service_request_name, SOURCE.note,SOURCE.encounter_service_request_current_status_name
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;