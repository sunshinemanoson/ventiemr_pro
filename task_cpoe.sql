SELECT        tc.encounter_id, tc.encounter_procedure_id, tc.encounter_service_request_id, tc.[group], ts.name AS task_status_name, ti.name AS task_intent_name, tc.description, tc.execution_start, tc.execution_end, 
                         rp.name AS task_priority_name, tc.note AS task_note, tc.created_at AS task_cpoe_created_at, tc.updated_at AS task_cpoe_updated_at, tcr.lab_order_number, tcr.lab_order_item_id, tcr.lab_order_specimen_id, 
                         tcr.radiology_order_number, tcr.radiology_order_region_id, tcr.radiology_order_region_modifier_id, tcr.treatment_order_id, tcr.treatment_order_item_id, tcr.in_encounter_medication_request_id, 
                         ts2.name AS task_cpoe_relation_status_name
FROM            [StgPanda].[ventiemr].[task_cpoe] AS tc LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[task_status] AS ts ON ts.id = tc.status_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[task_intent] AS ti ON ti.id = tc.intent_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[task_cpoe_relation] AS tcr ON tcr.task_cpoe_id = tc.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[request_priority] AS rp ON rp.id = tc.priority_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[task_status] AS ts2 ON ts2.id = tcr.status_id
where  tc.encounter_id IN(

    SELECT distinct  tc.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
)



DELETE FROM [StgPanda].[ventiemr].[condition_summary]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[condition_summary_temp]
		 )

INSERT INTO  [StgPanda].[ventiemr].[condition_summary]
SELECT * FROM 
[StgPanda].[ventiemr].[condition_summary_temp]


/*
WITH SourceUnique AS (
    SELECT 
        encounter_id,
        encounter_procedure_id,
        treatment_order_item_id,
        encounter_service_request_id,
        [group],
        task_status_name,
        task_intent_name,
        [description],
        execution_start,
        execution_end,
        task_priority_name,
        task_note,
        task_cpoe_created_at,
        task_cpoe_updated_at,
        lab_order_number,
        lab_order_item_id,
        lab_order_specimen_id,
        radiology_order_number,
        radiology_order_region_id,
        radiology_order_region_modifier_id,
        treatment_order_id,
        in_encounter_medication_request_id,
        task_cpoe_relation_status_name,
        ROW_NUMBER() OVER (PARTITION BY task_cpoe_updated_at ORDER BY (SELECT NULL)) AS rn
    FROM [StgPanda].[ventiemr].[task_CPOE_summary_temp]
)
MERGE INTO [StgPanda].[ventiemr].[task_CPOE_summary] AS TARGET
USING SourceUnique AS SOURCE
ON TARGET.task_cpoe_updated_at = SOURCE.task_cpoe_updated_at AND SOURCE.rn = 1
WHEN MATCHED AND (
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.encounter_procedure_id <> SOURCE.encounter_procedure_id
         OR TARGET.treatment_order_item_id <> SOURCE.treatment_order_item_id
         OR TARGET.encounter_service_request_id <> SOURCE.encounter_service_request_id
         OR TARGET.[group] <> SOURCE.[group]
         OR TARGET.task_status_name <> SOURCE.task_status_name
         OR TARGET.task_intent_name <> SOURCE.task_intent_name
         OR TARGET.[description] <> SOURCE.[description]
		 OR TARGET.execution_start <> SOURCE.execution_start
         OR TARGET.execution_end <> SOURCE.execution_end
         OR TARGET.task_priority_name <> SOURCE.task_priority_name
         OR TARGET.task_note <> SOURCE.task_note
         OR TARGET.task_cpoe_created_at <> SOURCE.task_cpoe_created_at
         OR TARGET.task_cpoe_updated_at <> SOURCE.task_cpoe_updated_at
         OR TARGET.lab_order_number <> SOURCE.lab_order_number
         OR TARGET.lab_order_item_id <> SOURCE.lab_order_item_id
         OR TARGET.lab_order_specimen_id <> SOURCE.lab_order_specimen_id
         OR TARGET.radiology_order_number <> SOURCE.radiology_order_number
         OR TARGET.radiology_order_region_id <> SOURCE.radiology_order_region_id
         OR TARGET.radiology_order_region_modifier_id <> SOURCE.radiology_order_region_modifier_id
         OR TARGET.treatment_order_id <> SOURCE.treatment_order_id
         OR TARGET.in_encounter_medication_request_id <> SOURCE.in_encounter_medication_request_id
         OR TARGET.task_cpoe_relation_status_name <> SOURCE.task_cpoe_relation_status_name  
) THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.encounter_procedure_id = SOURCE.encounter_procedure_id,
        TARGET.treatment_order_item_id = SOURCE.treatment_order_item_id,
        TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id,
        TARGET.[group] = SOURCE.[group],
        TARGET.task_status_name = SOURCE.task_status_name,
        TARGET.task_intent_name = SOURCE.task_intent_name,
        TARGET.[description] = SOURCE.[description],
		TARGET.execution_start = SOURCE.execution_start,
        TARGET.execution_end = SOURCE.execution_end,
        TARGET.task_priority_name = SOURCE.task_priority_name,
        TARGET.task_note = SOURCE.task_note,
        TARGET.task_cpoe_created_at = SOURCE.task_cpoe_created_at,
        TARGET.task_cpoe_updated_at = SOURCE.task_cpoe_updated_at,
        TARGET.lab_order_number = SOURCE.lab_order_number,
        TARGET.lab_order_item_id = SOURCE.lab_order_item_id,
        TARGET.lab_order_specimen_id = SOURCE.lab_order_specimen_id,
        TARGET.radiology_order_number = SOURCE.radiology_order_number,
        TARGET.radiology_order_region_id = SOURCE.radiology_order_region_id,
        TARGET.radiology_order_region_modifier_id = SOURCE.radiology_order_region_modifier_id,
        TARGET.treatment_order_id = SOURCE.treatment_order_id,
        TARGET.in_encounter_medication_request_id = SOURCE.in_encounter_medication_request_id,
        TARGET.task_cpoe_relation_status_name = SOURCE.task_cpoe_relation_status_name
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, encounter_procedure_id, treatment_order_item_id, 
		encounter_service_request_id, [group], task_status_name, 
		task_intent_name, [description],execution_start,
		execution_end,task_priority_name,task_note,
		task_cpoe_created_at,task_cpoe_updated_at,lab_order_number,
		lab_order_item_id,lab_order_specimen_id,radiology_order_number,
        radiology_order_region_id,radiology_order_region_modifier_id,treatment_order_id,
		in_encounter_medication_request_id,task_cpoe_relation_status_name
    )          
    VALUES (
        SOURCE.encounter_id, SOURCE.encounter_procedure_id, SOURCE.treatment_order_item_id, 
        SOURCE.encounter_service_request_id,  SOURCE.[group], SOURCE.task_status_name, 
        SOURCE.task_intent_name, SOURCE.[description], SOURCE.execution_start, 
		SOURCE.execution_end,SOURCE.task_priority_name , SOURCE.task_note , 
		SOURCE.task_cpoe_created_at ,SOURCE.task_cpoe_updated_at ,SOURCE.lab_order_number ,
		SOURCE.lab_order_item_id ,SOURCE.lab_order_specimen_id, SOURCE.radiology_order_number,
		SOURCE.radiology_order_region_id , SOURCE.radiology_order_region_modifier_id , SOURCE.treatment_order_id ,
		SOURCE.in_encounter_medication_request_id ,SOURCE.task_cpoe_relation_status_name
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;
