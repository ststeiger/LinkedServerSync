
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE' 
AND SPECIFIC_NAME NOT IN 
(
	SELECT name FROM sys.all_objects AS sp 
	WHERE (1=1) 
	AND (sp.type IN (N'P', N'PC', N'RF') )
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
