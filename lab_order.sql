WITH observation_verification_status AS (SELECT        id, name
                                                                                           FROM            ventiemr.observation_verification_status AS observation_verification_status_1)
    SELECT        lo.encounter_id, lo.encounter_procedure_id, lo.order_number, lo.department_id, ovs.name AS lab_order_verification_status, lo.note AS lab_order_note, lo.created_at AS lab_order_created_at, loi.id AS lab_order_item_id, 
                              loi.lab_category_id, loi.lab_panel_id, loi.lab_item_id, loi.department_room, ovs2.name AS lab_order_item_verification_status, loi.created_at AS lab_order_item_created_at, los.id AS lab_order_specimen_id, 
                              los.lab_specimen_group_id, los.lab_specimen_container_id, los.lab_specimen_site_id, los.container_remark, los.body_site_remark, los.laterality, los.note AS lab_order_specimen_note, 
                              ovs3.name AS lab_order_specimen_verification_status, los.created_at AS lab_order_specimen_created_at
     FROM            ventiemr.lab_order AS lo LEFT OUTER JOIN
                              observation_verification_status AS ovs ON ovs.id = lo.verification_status_id LEFT OUTER JOIN
                              ventiemr.lab_order_item AS loi ON loi.lab_order_number = lo.order_number LEFT OUTER JOIN
                              observation_verification_status AS ovs2 ON ovs2.id = loi.verification_status_id LEFT OUTER JOIN
                              ventiemr.lab_order_specimen AS los ON los.lab_order_item_id = loi.id LEFT OUTER JOIN
                              observation_verification_status AS ovs3 ON ovs3.id = los.verification_status_id
    where lo.encounter_id IN(

    SELECT distinct lo.encounter_id FROM  [StgPanda].[ventiemr].[lab_order]
                              where  cast(lo.created_at as date) >= cast(getdate()-3 as date)  
            or
	                        cast(los.created_at as date) >= cast(getdate()-3 as date)
    )

