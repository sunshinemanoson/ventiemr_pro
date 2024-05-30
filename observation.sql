SELECT        eofr.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, eofr.observation_form_id, of2.form_code, of2.display AS form_display, of2.observation_id AS observation_id_form, 
                         o.name AS observation_name_form, o.display AS observation_display_form, of2.is_active AS is_form_active, ovs.name AS observation_form_record_verification_status_name, 
                         eofri.id AS encounter_observation_form_record_item_id, eofri.observation_form_item_id, o2.id AS observation_id_form_item, o2.name AS observation_name_form_item, o2.display AS observation_display_form_item, 
                         ofi.display AS observation_form_item_display, ofi.value_type, eofri.data_json AS encounter_observation_form_record_item_data_json, eofri.observation_value AS encounter_observation_form_record_item_observation_value, 
                         eofri.created_at,eofri.updated_at
FROM                     [StgPanda].[ventiemr].[encounter_observation_form_record] AS eofr LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[encounter_procedure] AS ep ON ep.id = eofr.encounter_procedure_id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[observation_form] AS of2 ON eofr.observation_form_id = of2.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[observation_verification_status] AS ovs ON eofr.verification_status_id = ovs.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[procedure_category] AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[procedure_status] AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[observation] AS o ON of2.observation_id = o.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[encounter_observation_form_record_item] AS eofri ON eofr.id = eofri.based_on LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[observation_form_item] AS ofi ON eofri.observation_form_item_id = ofi.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[observation] AS o2 ON ofi.observation_id = o2.id
where eofr.encounter_id IN(

    SELECT distinct eofr.encounter_id FROM  [StgPanda].[ventiemr].[encounter_observation_form_record]
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
         OR TARGET. <> SOURCE.
         OR TARGET. <> SOURCE.
         OR TARGET. <> SOURCE.
         OR TARGET. <> SOURCE.
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.created_at = SOURCE.created_at,
		TARGET.updated_at = SOURCE.updated_at,
        TARGET. = SOURCE.,
        TARGET. = SOURCE.,
        TARGET. = SOURCE.,
		TARGET. = SOURCE.
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, created_at,updated_at,
        
    )          
    VALUES (
        SOURCE.encounter_id,SOURCE.created_at, SOURCE.updated_at,
        
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;