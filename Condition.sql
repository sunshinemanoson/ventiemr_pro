SELECT        ep.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, ec.id AS encounter_condition_id, cc.name AS condition_category_name, cvs.name AS condition_verification_status_name, 
                         ec.condition_id, c.standard_code, c.standard_display, c.standard_system, c.name AS condition_name, ec.condition_order, ec.condition_value, ec.note AS condition_note, ec.created_at
FROM            ventiemr.encounter_procedure AS ep LEFT OUTER JOIN
                         ventiemr.procedure_category AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                         ventiemr.encounter_condition AS ec ON ep.id = ec.based_on LEFT OUTER JOIN
                         ventiemr.procedure_status AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                         ventiemr.condition_category AS cc ON ec.category_id = cc.id LEFT OUTER JOIN
                         ventiemr.condition_verification_status AS cvs ON ec.verification_status_id = cvs.id LEFT OUTER JOIN
                         ventiemr.condition AS c ON c.id = ec.condition_id
where  cast(ep.created_at as date) >= cast(getdate()-3 as date)  
  or
	     cast(ep.updated_at as date) >= cast(getdate()-3 as date)
 