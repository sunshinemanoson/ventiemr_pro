SELECT        ep.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, ec.id AS encounter_condition_id, cc.name AS condition_category_name, cvs.name AS condition_verification_status_name, 
                         ec.condition_id, c.standard_code, c.standard_display, c.standard_system, c.name AS condition_name, ec.condition_order, ec.condition_value, ec.note AS condition_note, ec.created_at,ec.updated_at
FROM            [StgPanda].[ventiemr].[encounter_procedure] AS ep LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[procedure_category ]AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[encounter_condition] AS ec ON ep.id = ec.based_on LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[procedure_status] AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[condition_category] AS cc ON ec.category_id = cc.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[condition_verification_status] AS cvs ON ec.verification_status_id = cvs.id LEFT OUTER JOIN
                        [StgPanda].[ventiemr].[condition] AS c ON c.id = ec.condition_id
where ep.encounter_id IN(

SELECT distinct ep.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
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


    


WITH CST_SOURCE AS (
    SELECT 
        encounter_id,
        procedure_category_name,
        procedure_status_name,
        encounter_condition_id,
        condition_category_name,
        condition_verification_status_name,
        condition_id,
        standard_code,
        standard_display,
        standard_system,
        condition_name,
        condition_order,
        condition_value,
        condition_note,
        created_at,
        updated_at,
        ROW_NUMBER() OVER (PARTITION BY updated_at ORDER BY updated_at) AS rn
    FROM 
        [StgPanda].[ventiemr].[condition_summary_temp]
)
MERGE INTO [StgPanda].[ventiemr].[condition_summary] AS TARGET
USING (
    SELECT * 
    FROM CST_SOURCE 
    WHERE rn = 1
) AS SOURCE 
ON TARGET.updated_at = SOURCE.updated_at
WHEN MATCHED AND (
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
)
THEN 
    UPDATE SET 
        TARGET.encounter_id = SOURCE.encounter_id,
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
        standard_code, standard_display, standard_system, condition_name, condition_order, 
        condition_value, condition_note, created_at, updated_at
    )          
    VALUES (
        SOURCE.encounter_id, SOURCE.procedure_category_name, SOURCE.procedure_status_name, 
        SOURCE.encounter_condition_id, SOURCE.condition_category_name, 
        SOURCE.condition_verification_status_name, SOURCE.condition_id, 
        SOURCE.standard_code, SOURCE.standard_display, SOURCE.standard_system, 
        SOURCE.condition_name, SOURCE.condition_order, SOURCE.condition_value, 
        SOURCE.condition_note, SOURCE.created_at, SOURCE.updated_at
    )
WHEN NOT MATCHED BY SOURCE 
THEN 
    DELETE;
