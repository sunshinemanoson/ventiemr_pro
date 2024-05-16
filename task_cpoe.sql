SELECT        tc.encounter_id, tc.encounter_procedure_id, tc.encounter_service_request_id, tc.[group], ts.name AS task_status_name, ti.name AS task_intent_name, tc.description, tc.execution_start, tc.execution_end, 
                         rp.name AS task_priority_name, tc.note AS task_note, tc.created_at AS task_cpoe_created_at, tc.updated_at AS task_cpoe_updated_at, tcr.lab_order_number, tcr.lab_order_item_id, tcr.lab_order_specimen_id, 
                         tcr.radiology_order_number, tcr.radiology_order_region_id, tcr.radiology_order_region_modifier_id, tcr.treatment_order_id, tcr.treatment_order_item_id, tcr.in_encounter_medication_request_id, 
                         ts2.name AS task_cpoe_relation_status_name
FROM            ventiemr.task_cpoe AS tc LEFT OUTER JOIN
                         ventiemr.task_status AS ts ON ts.id = tc.status_id LEFT OUTER JOIN
                         ventiemr.task_intent AS ti ON ti.id = tc.intent_id LEFT OUTER JOIN
                         ventiemr.task_cpoe_relation AS tcr ON tcr.task_cpoe_id = tc.id LEFT OUTER JOIN
                         ventiemr.request_priority AS rp ON rp.id = tc.priority_id LEFT OUTER JOIN
                         ventiemr.task_status AS ts2 ON ts2.id = tcr.status_id
WHERE        (CAST(tc.created_at AS date) >= CAST(GETDATE() - 3 AS date)) OR
                         (CAST(tc.updated_at AS date) >= CAST(GETDATE() - 3 AS date))