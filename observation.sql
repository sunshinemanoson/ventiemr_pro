SELECT        eofr.encounter_id, pc.name AS procedure_category_name, ps.name AS procedure_status_name, eofr.observation_form_id, of2.form_code, of2.display AS form_display, of2.observation_id AS observation_id_form, 
                         o.name AS observation_name_form, o.display AS observation_display_form, of2.is_active AS is_form_active, ovs.name AS observation_form_record_verification_status_name, 
                         eofri.id AS encounter_observation_form_record_item_id, eofri.observation_form_item_id, o2.id AS observation_id_form_item, o2.name AS observation_name_form_item, o2.display AS observation_display_form_item, 
                         ofi.display AS observation_form_item_display, ofi.value_type, eofri.data_json AS encounter_observation_form_record_item_data_json, eofri.observation_value AS encounter_observation_form_record_item_observation_value, 
                         eofri.created_at
FROM            ventiemr.encounter_observation_form_record AS eofr LEFT OUTER JOIN
                         ventiemr.encounter_procedure AS ep ON ep.id = eofr.encounter_procedure_id LEFT OUTER JOIN
                         ventiemr.observation_form AS of2 ON eofr.observation_form_id = of2.id LEFT OUTER JOIN
                         ventiemr.observation_verification_status AS ovs ON eofr.verification_status_id = ovs.id LEFT OUTER JOIN
                         ventiemr.procedure_category AS pc ON ep.category_id = pc.id LEFT OUTER JOIN
                         ventiemr.procedure_status AS ps ON ep.current_status_id = ps.id LEFT OUTER JOIN
                         ventiemr.observation AS o ON of2.observation_id = o.id LEFT OUTER JOIN
                         ventiemr.encounter_observation_form_record_item AS eofri ON eofr.id = eofri.based_on LEFT OUTER JOIN
                         ventiemr.observation_form_item AS ofi ON eofri.observation_form_item_id = ofi.id LEFT OUTER JOIN
                         ventiemr.observation AS o2 ON ofi.observation_id = o2.id
                         where  cast( eofri.created_at as date) >= cast(getdate()-3 as date)  
  or
	     cast( eofri.updated_at as date) >= cast(getdate()-3 as date)