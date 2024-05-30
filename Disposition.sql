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




/*STRAT UPDATE*/
DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'encounter_procedure';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [StgPanda].[ventiemr].[log_job] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [StgPanda].[ventiemr].[log_job] ([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 



SELECT        ep.id AS encounter_id, ds.department_name, ds.hospital_name, ds.note, ds.zone_id, dt.name AS disposition_type_name, dt.display AS disposition_type_display, dt.display_th AS disposition_type_display_th
FROM            ventiemr.encounter_procedure AS ep LEFT OUTER JOIN
                         ventiemr.disposition_summary AS ds ON ep.disposition_summary_id = ds.id LEFT OUTER JOIN
                         ventiemr.disposition_type AS dt ON ds.disposition_type_id = dt.id



/*Stop Update */

DECLARE @Table_Target VARCHAR(255) = 'encounter_procedure';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [StgPanda].[ventiemr].[log_job]
SET [Job_End] = GETDATE()
,[Job_Status] = 'Success'
,[NoRow] = (select count(1) from [StgPanda].[ventiemr].[encounter_procedure_temp])
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)
------------------------------------------------------------------------------



/* */
DELETE FROM [StgPanda].[ventiemr].[encounter_procedure_temp]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[encounter_procedure_tempdev]
		 )

INSERT INTO  [StgPanda].[ventiemr].[encounter_procedure_temp]
SELECT * FROM 
[StgPanda].[ventiemr].[encounter_procedure_tempdev]


SELECT       encounter_id AS ep ,*
FROM           [StgPanda].[ventiemr].[encounter_procedure_temp]
WHERE DATEADD(DAY,-39999,GETDATE()) <= cast([created_at] as date) OR
      DATEADD(DAY,-39999,GETDATE()) <= cast([updated_at] as date);



DELETE FROM [StgPanda].[ventiemr].[encounter_procedure_temp]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[encounter_procedure_tempdev]
		 )

INSERT INTO  [StgPanda].[ventiemr].[encounter_procedure_temp]
SELECT * FROM 
[StgPanda].[ventiemr].[encounter_procedure_tempdev]