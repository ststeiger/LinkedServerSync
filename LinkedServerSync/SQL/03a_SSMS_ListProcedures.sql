
DECLARE @__for_database nvarchar(4000)
--SET @__for_database=N'COR_Basic_Demo_V4'
SET @__for_database=DB_NAME()


DECLARE @__show_system_procedures bit 
SET @__show_system_procedures='false' 



DECLARE @is_policy_automation_enabled bit
SET @is_policy_automation_enabled  = ( SELECT CONVERT(bit, current_value) FROM msdb.dbo.syspolicy_configuration WHERE name = 'Enabled' )


SELECT 
	 SCHEMA_NAME(sp.schema_id) AS RoutineSchema 
	,sp.NAME AS RoutineName 
	,ISNULL(smsp.DEFINITION, ssmsp.DEFINITION) AS RoutineDefinition 
	
	,
	(
		  'Server[@Name=' 
		+ QUOTENAME(CAST(SERVERPROPERTY(N'Servername') AS sysname), '''') 
		+ ']' 
		+ '/Database[@Name=' 
		+ QUOTENAME(DB_NAME(), '''') 
		+ ']' + '/StoredProcedure[@Name=' 
		+ QUOTENAME(sp.NAME, '''') 
		+ ' and @Schema=' 
		+ QUOTENAME(SCHEMA_NAME(sp.schema_id), '''') 
		+ ']' 
	) AS URN  
	
	--,CASE 
	--	WHEN 1 = @is_policy_automation_enabled
	--		AND EXISTS 
	--		(
	--			SELECT *
	--			FROM msdb.dbo.syspolicy_system_health_state
	--			WHERE target_query_expression_with_id LIKE 'Server' + '/Database\[@ID=' + convert(NVARCHAR(20), dtb.database_id) + '\]' + '/StoredProcedure\[@ID=' + convert(NVARCHAR(20), sp.object_id) + '\]%' ESCAPE '\'
	--		)
	--		THEN 1
	--	ELSE 0
	--END AS PolicyHealthState 
	
	,sp.create_date AS CREATED
	,ISNULL(ssp.NAME, N'') AS OBJECT_OWNER  
	
	,CAST
	(
		CASE 
			WHEN ISNULL(smsp.DEFINITION, ssmsp.DEFINITION) IS NULL
				THEN 1
			ELSE 0
		END AS BIT
	) AS IsEncrypted 
	
	,
	CASE 
		WHEN sp.type = N'P'
			THEN 1
		WHEN sp.type = N'PC'
			THEN 2
		ELSE 1
	END AS ImplementationType 
	
FROM sys.all_objects AS sp 

INNER JOIN master.sys.databases AS dtb 
	ON 
	(
		(DB_NAME() = @__for_database) 
		AND 
		(dtb.NAME = DB_NAME() )  
	)
	
LEFT JOIN sys.database_principals AS ssp
	ON ssp.principal_id = ISNULL(sp.principal_id, (OBJECTPROPERTY(sp.object_id, 'OwnerId')))
	
LEFT JOIN sys.sql_modules AS smsp
	ON smsp.object_id = sp.object_id
	
LEFT JOIN sys.system_sql_modules AS ssmsp
	ON ssmsp.object_id = sp.object_id
	
WHERE (1=1) 

AND 
(
	sp.type IN (N'P', N'PC', N'RF')
)
AND 
(
	CAST
	(
		CASE 
			WHEN sp.is_ms_shipped = 1
				THEN 1
			WHEN 
				(
					SELECT major_id FROM sys.extended_properties
					WHERE major_id = sp.object_id AND minor_id = 0
					AND class = 1 AND NAME = N'microsoft_database_tools_support'
				) IS NOT NULL
				THEN 1
			ELSE 0
		END AS bit 
	) = @__show_system_procedures
) 

 -- Don't show encrypted procedures 
AND 
( 
	CAST
	( 
		CASE 
			WHEN ISNULL(smsp.DEFINITION, ssmsp.DEFINITION) IS NULL 
				THEN 1 
			ELSE 0 
		END AS bit 
	) = 0 
) 

ORDER BY 
	 RoutineSchema ASC 
	,RoutineName ASC 
	 