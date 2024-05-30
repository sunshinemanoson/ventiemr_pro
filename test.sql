DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [dbo].[T_DB_Update] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [dbo].[T_DB_Update]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 



DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [dbo].[T_DB_Update]
SET [Job_End] = GETDATE()
,[Job_Status] = 'Success'
,[NoRow] = (select count(1) from [StgPanda].[dbo].[adverse_event_vitalsign_temp])
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)
------------------------------------------------------------------------------
DELETE FROM [StgPanda].[dbo].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[dbo].[adverse_event_vitalsign_temp]
		 )



DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [dbo].[T_DB_Update] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [dbo].[T_DB_Update]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 



DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [StgPanda].[ventiemr].[log_job] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [StgPanda].[ventiemr].[log_job] ([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 


INSERT INTO  [StgPanda].[ventiemr].[log_job]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES ('StgPanda','adverse_event_vitalsignt',GETDATE(),'All','Start') 


INSERT INTO [dbo].[T_DB_Update]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 


DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [StgPanda].[ventiemr].[log_job]
SET [Job_End] = GETDATE()
,[Job_Status] = 'Success'
,[NoRow] = (select count(1) from [StgPanda].[dbo].[adverse_event_vitalsign_temp])
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)
------------------------------------------------------------------------------
DELETE FROM [StgPanda].[dbo].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[dbo].[adverse_event_vitalsign_temp]
		 )


DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [StgPanda].[dbo].[adverse_event_vitalsign] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [StgPanda].[dbo].[adverse_event_vitalsign]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 


DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [StgPanda].[ventiemr].[log_job]
SET [Job_End] = GETDATE()
,[Job_Status] = 'Success'
,[NoRow] = (select count(1) from [StgPanda].[ventiemr].[adverse_event_vitalsign_temp])
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)
------------------------------------------------------------------------------
DELETE FROM [StgPanda].[ventiemr].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[adverse_event_vitalsign]
		 )


DELETE FROM [StgPanda].[ventiemr].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[adverse_event_vitalsign]
		 )

INSERT INTO  [StgPanda].[ventiemr].[adverse_event_vitalsign]
SELECT * FROM 
[StgPanda].[ventiemr].[adverse_event_vitalsign]



DELETE FROM [SiIMC_MGHT].[dbo].[T_BL_ENCOUNTER_PAYER_PRIORITY]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[SiIMC_MGHT].[dbo].[T_BL_ENCOUNTER_PAYER_PRIORITY_TEMP]
		 )

INSERT INTO  [SiIMC_MGHT].[dbo].[T_BL_ENCOUNTER_PAYER_PRIORITY]
SELECT * FROM 
[SiIMC_MGHT].[dbo].[T_BL_ENCOUNTER_PAYER_PRIORITY_TEMP]


DELETE FROM [StgPanda].[ventiemr].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[StgPanda].[ventiemr].[adverse_event_vitalsign_temp]
		 )

INSERT INTO  [StgPanda].[ventiemr].[adverse_event_vitalsign]
SELECT * FROM 
[StgPanda].[ventiemr].[adverse_event_vitalsign_temp]


DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [StgPanda].[ventiemr].[adverse_event_vitalsign]
SET [Job_Failed_At] = GETDATE()
,[Job_Status] = 'Failed'
,[NoRow] = 0
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)