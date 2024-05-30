DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [dbo].[T_DB_Update] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [dbo].[T_DB_Update]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 

-------------------------------------------------------------------------------------------------------------------------------------------------------------
truncate table [SiIMC_MGHT].[dbo].[adverse_event_vitalsign_temp]
-------------------------------------------------------------------------------------------------------------------------------------------------------------

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
DELETE FROM [SiIMC_MGHT].[dbo].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[SiIMC_MGHT].[dbo].[adverse_event_vitalsign_temp]
		 )

INSERT INTO  [SiIMC_MGHT].[dbo].[adverse_event_vitalsign]
SELECT * FROM 
[SiIMC_MGHT].[dbo].[adverse_event_vitalsign_temp]  

-------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE [dbo].[T_DB_Update]
SET [Job_Failed_At] = GETDATE()
,[Job_Status] = 'Failed'
,[NoRow] = 0
WHERE 
[DB_Target] = 'StgPanda' 
and [Table_Target] = @Table_Target
and CAST([Job_Start] as date) = CAST(GETDATE() as date)


DELETE FROM [SiIMC_MGHT].[dbo].[adverse_event_vitalsign]
where encounter_id IN(
SELECT distinct encounter_id FROM 
[SiIMC_MGHT].[dbo].[adverse_event_vitalsign_temp]
		 )

INSERT INTO  [SiIMC_MGHT].[dbo].[adverse_event_vitalsign]
SELECT * FROM 
[SiIMC_MGHT].[dbo].[adverse_event_vitalsign_temp]


DECLARE @DB_Target VARCHAR(255) = 'StgPanda';
DECLARE @Table_Target VARCHAR(255) = 'adverse_event_vitalsign';
DECLARE @preiod VARCHAR(255) = 'All';
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM [dbo].[T_DB_Update] where [DB_Target] = @DB_Target and [Table_Target] = @Table_Target and CAST([Job_Start] as date) = CAST(GETDATE() as date)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [dbo].[T_DB_Update]([DB_Target],[Table_Target],[Job_Start],[All_Month],[Job_Status])
VALUES (@DB_Target,@Table_Target,GETDATE(),@preiod,'Start') 