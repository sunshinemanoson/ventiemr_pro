SELECT        esr.encounter_id, esr.id AS encounter_service_request_id, sr.name AS service_request_name, esr.note, srs.name AS service_request_status_name, esrs.created_at
FROM            ventiemr.encounter_service_request AS esr LEFT OUTER JOIN
                         ventiemr.service_request AS sr ON esr.service_request_id = sr.id LEFT OUTER JOIN
                         ventiemr.encounter_service_request_status AS esrs ON esr.id = esrs.encounter_service_request_id LEFT OUTER JOIN
                         ventiemr.service_request_status AS srs ON esrs.service_request_status_id = srs.id
WHERE        (esr.id IS NOT NULL) AND  cast( esrs.created_at as date) >= cast(getdate()-3 as date)  
  or
	     cast( esrs.updated_at as date) >= cast(getdate()-3 as date)