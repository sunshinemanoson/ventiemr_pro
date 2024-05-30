SELECT        to2.encounter_id, to2.encounter_procedure_id, to2.category_id, to2.created_at AS treatment_order_created_at, toi.id AS treatment_order_item_id, toi.treatment_item_id, toi.optional_note, 
                         ps.name AS treatment_order_item_status_name
FROM           [StgPanda].[ventiemr].[treatment_order] AS to2 LEFT OUTER JOIN
                          [StgPanda].[ventiemr].[treatment_order_item] AS toi ON toi.treatment_order_id = to2.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[procedure_status] AS ps ON ps.id = toi.current_status_id

where to2.encounter_id IN(

SELECT distinct to2.encounter_id FROM  [StgPanda].[ventiemr].[encounter_procedure]
WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
)



DELETE FROM [StgPanda].[ventiemr].[CPOE_treatment_summary]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[CPOE_treatment_summary_temp]
   )

INSERT INTO  [StgPanda].[ventiemr].[CPOE_treatment_summary]
SELECT * FROM 
[StgPanda].[ventiemr].[CPOE_treatment_summary_temp]