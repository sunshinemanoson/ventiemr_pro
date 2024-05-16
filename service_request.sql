SELECT        ep.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, esr.id AS encounter_service_request_id, sr.name AS service_request_name, esr.note, 
                         srs.name AS encounter_service_request_current_status_name, esr.created_at, esr.updated_at
FROM            ventiemr.encounter_procedure AS ep LEFT OUTER JOIN
                         ventiemr.procedure_category AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                         ventiemr.procedure_status AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                         ventiemr.encounter_service_request AS esr ON ep.based_on = esr.id LEFT OUTER JOIN
                         ventiemr.service_request AS sr ON esr.service_request_id = sr.id LEFT OUTER JOIN
                         ventiemr.service_request_status AS srs ON esr.current_status_id = srs.id
WHERE        (CAST(esr.created_at AS date) >= CAST(GETDATE() - 3 AS date)) OR
                         (CAST(esr.updated_at AS date) >= CAST(GETDATE() - 3 AS date))