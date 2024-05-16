SELECT        ep.id AS encounter_id, ds.department_name, ds.hospital_name, ds.note, ds.zone_id, dt.name AS disposition_type_name, dt.display AS disposition_type_display, dt.display_th AS disposition_type_display_th
FROM           ventiemr.encounter_procedure AS ep LEFT OUTER JOIN
                         ventiemr.disposition_summary AS ds ON ep.disposition_summary_id = ds.id LEFT OUTER JOIN
                         ventiemr.disposition_type AS dt ON ds.disposition_type_id = dt.id


SELECT  ep.id AS encounter_id,
        ds.department_name,
        ds.hospital_name,
        ds.note,
        ds.zone_id,
        dt.name AS disposition_type_name,
        dt.display AS disposition_type_display,
        dt.display_th AS disposition_type_display_th 
FROM [StgPanda].[ventiemr].encounter_procedure AS ep 
LEFT JOIN [StgPanda].[ventiemr].disposition_summary AS ds ON ep.disposition_summary_id = ds.id 
LEFT JOIN [StgPanda].[ventiemr].disposition_type AS dt ON ds.disposition_type_id = dt.id

where ep.encounter_id IN(

SELECT distinct ep.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
where  cast(ep.created_at as date) >= cast(getdate()-3 as date)  
  or
	     cast(ep.updated_at as date) >= cast(getdate()-3 as date)
)
//*ADverd */
SELECT  encounter_id,
 created_at,
  encounter_procedure_id,
   systolic_pressure,
    sbp_interpretation,
     diastolic_pressure,
      dbp_interpretation,
       pulse_rate,
        pr_interpretation,
         respiratory_rate,
          rr_interpretation,
           body_temperature, 
            bt_interpretation,
             oxygen_saturation,
              spo2_interpretation,
               summary_interpretation,
                summary_interpretation_text,
                 assessment_score_model,
                  assessment_score_user
FROM [StgPanda].[ventiemr].adverse_event_vitalsign AS aev
WHERE CAST(created_at AS DATE) < CAST(GETDATE() - 3 AS DATE)
ORDER BY  created_at DESC