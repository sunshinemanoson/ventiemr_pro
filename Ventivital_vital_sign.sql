SELECT        eo.encounter_id, o.code, o.name, eo.value, eo.value_at, eo.grouping_at, eo.created_at
FROM                     [StgPanda].[ventivitalsign].[encounter_observation] AS eo LEFT OUTER JOIN
                         [StgPanda].[ventivitalsign].[observation] AS o ON o.id = eo.observation_id

where  eo.encounter_id IN(
    SELECT distinct   eo.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
                            WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
    )