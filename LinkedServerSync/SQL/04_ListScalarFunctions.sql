
-- Scalar functions 
SELECT 
	 SPECIFIC_SCHEMA AS FunctionSchema 
	,SPECIFIC_NAME AS FunctionName 
	,OBJECT_DEFINITION(OBJECT_ID(QUOTENAME(SPECIFIC_SCHEMA) + '.' + QUOTENAME(SPECIFIC_NAME)) ) AS FunctionDefinition 
	--,DATA_TYPE
	--,CHARACTER_MAXIMUM_LENGTH
	--,NUMERIC_PRECISION	
	----,NUMERIC_PRECISION_RADIX	
	--,NUMERIC_SCALE 
	--,DATETIME_PRECISION
	--,CREATED
	--,LAST_ALTERED
FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND DATA_TYPE <> 'TABLE' 
AND SPECIFIC_NAME NOT IN 
(
	SELECT name FROM sys.all_objects AS sp 
	WHERE (1=1) 
	AND (sp.type IN (N'FN', N'IF', N'TF', N'FS', N'FT') )
	AND 
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
		END = 1 
	) 
)
