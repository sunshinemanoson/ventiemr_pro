SELECT        ep.encounter_id, tt.name AS trauma_type_name, moa.name AS mode_of_arrival_name, tn.disposition_on_arrival, tn.type, tn.created_at, tn.updated_at
FROM            [StgPanda].[ventiemr].[encounter_procedure] AS ep LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[triage_note] AS tn ON tn.encounter_procedure_id = ep.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[trauma_type] AS tt ON tt.id = tn.trauma_type_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[mode_of_arrival] AS moa ON moa.id = tn.mode_of_arrival_id
where  ep.encounter_id IN(
    SELECT distinct  ep.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
                            WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
    )


 



DELETE FROM [StgPanda].[ventiemr].[triage_note_summary]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[triage_note_summary_temp]
		 )

INSERT INTO  [StgPanda].[ventiemr].[triage_note_summary]
SELECT * FROM 
[StgPanda].[ventiemr].[triage_note_summary_temp]


Success perfromace pass
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