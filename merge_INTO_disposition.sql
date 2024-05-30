MERGE INTO [StgPanda].[ventiemr].[condition_summary] AS TARGET
USING [StgPanda].[ventiemr].[condition_summary_temp] AS SOURCE 
ON (TARGET.updated_at = SOURCE.updated_at) 
WHEN MATCHED AND 
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.procedure_category_name <> SOURCE.procedure_category_name
         OR TARGET.procedure_status_name <> SOURCE.procedure_status_name
         OR TARGET.encounter_condition_id <> SOURCE.encounter_condition_id
         OR TARGET.condition_category_name <> SOURCE.condition_category_name
         OR TARGET.condition_verification_status_name <> SOURCE.condition_verification_status_name
         OR TARGET.condition_id <> SOURCE.condition_id
         OR TARGET.standard_code <> SOURCE.standard_code
         OR TARGET.standard_display <> SOURCE.standard_display
         OR TARGET.standard_system <> SOURCE.standard_system
         OR TARGET.condition_name <> SOURCE.condition_name
         OR TARGET.condition_order <> SOURCE.condition_order
         OR TARGET.condition_value <> SOURCE.condition_value
         OR TARGET.condition_note <> SOURCE.condition_note
         OR TARGET.created_at <> SOURCE.created_at
         OR TARGET.updated_at <> SOURCE.updated_at
     
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.procedure_category_name = SOURCE.procedure_category_name,
        TARGET.procedure_status_name = SOURCE.procedure_status_name,
        TARGET.encounter_condition_id = SOURCE.encounter_condition_id,
        TARGET.condition_category_name = SOURCE.condition_category_name,
        TARGET.condition_verification_status_name = SOURCE.condition_verification_status_name,
        TARGET.condition_id = SOURCE.condition_id,
        TARGET.standard_code = SOURCE.standard_code,
        TARGET.standard_display = SOURCE.standard_display,
        TARGET.standard_system = SOURCE.standard_system,
        TARGET.condition_name = SOURCE.condition_name,
        TARGET.condition_order = SOURCE.condition_order,
        TARGET.condition_value = SOURCE.condition_value,
        TARGET.condition_note = SOURCE.condition_note,
        TARGET.created_at = SOURCE.created_at,
        TARGET.updated_at = SOURCE.updated_at
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, procedure_category_name, procedure_status_name, encounter_condition_id, 
        condition_category_name, condition_verification_status_name, condition_id, 
        standard_display,standard_system,condition_name,condition_order,condition_value,condition_note,created_at,
        updated_at
    )          
    VALUES (
        SOURCE.encounter_id, SOURCE.procedure_category_name, SOURCE.procedure_status_name, 
        SOURCE.encounter_condition_id,  SOURCE.condition_category_name, SOURCE.condition_verification_status_name, 
        SOURCE.condition_id, SOURCE.standard_display, SOURCE.standard_system, SOURCE.condition_name,
        SOURCE.condition_order, SOURCE.condition_value, SOURCE.condition_note, SOURCE.created_at,SOURCE.updated_at
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;



MERGE INTO [StgPanda].[ventiemr].[task_CPOE_summary] AS TARGET
USING [StgPanda].[ventiemr].[task_CPOE_summary_temp] AS SOURCE 
ON (TARGET.task_cpoe_updated_at = SOURCE.task_cpoe_updated_at) 
WHEN MATCHED AND 
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.encounter_procedure_id <> SOURCE.encounter_procedure_id
         OR TARGET.treatment_order_item_id <> SOURCE.treatment_order_item_id
         OR TARGET.encounter_service_request_id <> SOURCE.encounter_service_request_id
         OR TARGET.[group] <> SOURCE.[group]
         OR TARGET.task_status_name <> SOURCE.task_status_name
         OR TARGET.task_intent_name <> SOURCE.task_intent_name
         OR TARGET.description <> SOURCE.description
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
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.encounter_procedure_id = SOURCE.encounter_procedure_id,
        TARGET.treatment_order_item_id = SOURCE.treatment_order_item_id,
        TARGET.encounter_service_request_id = SOURCE.encounter_service_request_id,
        TARGET.[group] = SOURCE.[group],
        TARGET.task_status_name = SOURCE.task_status_name,
        TARGET.task_intent_name = SOURCE.task_intent_name,
        TARGET.description = SOURCE.description,
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
        TARGET.in_encounter_medication_request_id = SOURCE.in_encounter_medication_request_id
        TARGET.task_cpoe_relation_status_name = SOURCE.task_cpoe_relation_status_name
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, encounter_procedure_id, treatment_order_item_id, encounter_service_request_id, 
        [group], task_status_name, task_intent_name, 
        description,execution_start,execution_end,task_priority_name,task_note,task_cpoe_created_at,
        task_cpoe_updated_at,lab_order_number,lab_order_item_id,lab_order_specimen_id,radiology_order_number,
        radiology_order_region_id,radiology_order_region_modifier_id,treatment_order_id,in_encounter_medication_request_id,
        task_cpoe_relation_status_name
    )          
    VALUES (
        SOURCE.encounter_id, SOURCE.encounter_procedure_id, SOURCE.treatment_order_item_id, 
        SOURCE.encounter_service_request_id,  SOURCE.[group], SOURCE.task_status_name, 
        SOURCE.task_intent_name, SOURCE.description, SOURCE.execution_start, SOURCE.execution_end,
        SOURCE.task_priority_name , SOURCE.task_note , SOURCE.task_cpoe_created_at , SOURCE.task_cpoe_updated_at ,
         SOURCE.lab_order_number , SOURCE.lab_order_item_id , SOURCE.lab_order_specimen_id, SOURCE.radiology_order_number,
         SOURCE.radiology_order_region_id , SOURCE.radiology_order_region_modifier_id ,
        SOURCE.treatment_order_id ,SOURCE.in_encounter_medication_request_id , SOURCE.task_cpoe_relation_status_name
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;


/*
CREATE TABLE [StgPanda].[ventiemr].[encounter_procedure_temp_merge]
AS
(SELECT  ep.id AS encounter_id,
        ds.department_name,
        ds.hospital_name,
        ds.note,
        ds.zone_id,
        dt.name AS disposition_type_name,
        dt.display AS disposition_type_display,
        dt.display_th AS disposition_type_display_th,
		ep.updated_at
FROM [StgPanda].[ventiemr].encounter_procedure AS ep 
LEFT JOIN [StgPanda].[ventiemr].disposition_summary AS ds ON ep.disposition_summary_id = ds.id 
LEFT JOIN [StgPanda].[ventiemr].disposition_type AS dt ON ds.disposition_type_id = dt.id


update_at
MERGE INTO [StgPanda].[ventiemr].[triage_note_summary] AS TARGET
USING [StgPanda].[ventiemr].[triage_note_summary_temp] AS SOURCE 
ON (TARGET.updated_at = SOURCE.updated_at) 
WHEN MATCHED AND 
         TARGET.encounter_id <> SOURCE.encounter_id 
         OR TARGET.trauma_type_name <> SOURCE.trauma_type_name
         OR TARGET.mode_of_arrival_name <> SOURCE.mode_of_arrival_name
         OR TARGET.disposition_on_arrival <> SOURCE.disposition_on_arrival
         OR TARGET.type <> SOURCE.type
         OR TARGET.created_at <> SOURCE.created_at
         OR TARGET.updated_at <> SOURCE.updated_at
THEN 
    UPDATE 
    SET TARGET.encounter_id = SOURCE.encounter_id,
        TARGET.trauma_type_name = SOURCE.trauma_type_name,
        TARGET.mode_of_arrival_name = SOURCE.mode_of_arrival_name,
        TARGET.disposition_on_arrival = SOURCE.disposition_on_arrival,
        TARGET.type = SOURCE.type,
        TARGET.created_at = SOURCE.created_at,
		TARGET.updated_at = SOURCE.updated_at
WHEN NOT MATCHED BY TARGET 
THEN 
    INSERT (
        encounter_id, trauma_type_name,
        disposition_on_arrival, type, created_at
        ,updated_at
    )          
    VALUES (
        SOURCE.encounter_id,  SOURCE.trauma_type_name,
         SOURCE.disposition_on_arrival, SOURCE.type, 
        SOURCE.created_at, SOURCE.updated_at
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;