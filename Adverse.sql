SELECT        created_at
      created_by
      updated_at
      updated_by
      id
      encounter_id
      encounter_procedure_id
      systolic_pressure
      sbp_interpretation
      diastolic_pressure
      dbp_interpretation
      pulse_rate
      pr_interpretation
      respiratory_rate
      rr_interpretation
      body_temperature
      bt_interpretation
      oxygen_saturation
      spo2_interpretation
      summary_interpretation
      summary_interpretation_text
      assessment_score_model
      assessment_score_user
FROM            ventiemr.adverse_event_vitalsign AS aev
where encounter_id IN(

SELECT distinct encounter_id FROM  [StgPanda].[ventiemr].[adverse_event_vitalsign]
WHERE        (CAST(created_at AS date) >= CAST(GETDATE() - 3 AS date)) OR
                         (CAST(updated_at AS date) >= CAST(GETDATE() - 3 AS date))
)