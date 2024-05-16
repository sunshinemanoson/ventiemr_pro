SELECT        ep.encounter_id, tt.name AS trauma_type_name, moa.name AS mode_of_arrival_name, tn.disposition_on_arrival, tn.type, tn.created_at
FROM            ventiemr.encounter_procedure AS ep LEFT OUTER JOIN
                         ventiemr.triage_note AS tn ON tn.encounter_procedure_id = ep.id LEFT OUTER JOIN
                         ventiemr.trauma_type AS tt ON tt.id = tn.trauma_type_id LEFT OUTER JOIN
                         ventiemr.mode_of_arrival AS moa ON moa.id = tn.mode_of_arrival_id
where  ep.encounter_id IN(
    SELECT distinct  ep.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
WHERE        (CAST(tn.created_at AS date) >= CAST(GETDATE() - 3 AS date)) 
OR
            (CAST(tn.updated_at AS date) >= CAST(GETDATE() - 3 AS date))
)