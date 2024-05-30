SELECT        ro.encounter_id, ro.order_number, ro.description, iss.name AS radiology_order_status_name, ro.created_at AS radiology_order_created_at, ror.id AS radiology_order_item_id, ror.modality_subtype_id, ror.region_id, 
                         ror.region_text, ror.laterality, ror.is_substance, ror.description AS Expr1, ror.modality_id, ror.modality, ror.created_at AS radiology_order_region_created_at, iss2.name AS radiology_order_region_status_name, 
                         rorm.id AS radiology_order_region_modifier_id, rorm.modality_qualifier_id, rorm.region_subpart_id, rorm.region_subpart_text, rorm.region_qualifier_id, rorm.region_qualifier_text, rorm.note, 
                         rorm.created_at AS radiology_order_region_modifier_created_at, iss3.name AS radiology_order_region_modifier_status_name, ros.id AS radiology_order_set_id, ros.rad_study_set_id, ros.note AS radiology_order_set_note, 
                         ros.created_at AS radiology_order_set_created_at, iss4.name AS radiology_order_set_status_name, ror2.id AS radiology_order_set_region_id, ror2.modality_subtype_id AS radiology_order_set_modality_subtype_id, 
                         ror2.region_id AS Expr2, ror2.region_text AS radiology_order_set_region_text, ror2.laterality AS radiology_order_set_laterality, ror2.is_substance AS radiology_order_set_is_substance, 
                         ror2.description AS radiology_order_set_description, ror2.modality_id AS radiology_order_set_modality_id, ror2.modality AS radiology_order_set_modality, ror2.created_at AS radiology_order_set_region_created_at
FROM                     [StgPanda].[ventiemr].[radiology_order] AS ro LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[imaging_study_status] AS iss ON ro.imaging_study_status_id = iss.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[radiology_order_region] AS ror ON ror.rad_order_number = ro.order_number LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[imaging_study_status] AS iss2 ON iss2.id = ror.imaging_study_status_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[radiology_order_region_modifier] AS rorm ON ror.id = rorm.rad_order_region_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[imaging_study_status] AS iss3 ON iss3.id = rorm.imaging_study_status_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[radiology_order_set] AS ros ON ros.rad_order_number = ro.order_number LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[imaging_study_status] AS iss4 ON iss4.id = ros.imaging_study_status_id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[radiology_order_set_region_relation] AS rosrr ON rosrr.rad_order_set_id = ros.id LEFT OUTER JOIN
                         [StgPanda].[ventiemr].[radiology_order_region] AS ror2 ON ror2.id = rosrr.rad_order_region_id
where ro.encounter_id IN(

    SELECT distinct ro.encounter_id FROM  [StgPanda].[ventiemr].[encounter_observation_form_record]
WHERE DATEADD(DAY,-3999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-3999,GETDATE()) <= cast([updated_at] as date)
)

Radiology_order_summary