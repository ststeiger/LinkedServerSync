

SELECT 
	 sysSchema.name
	,sysSynonyms.name
	,type
	,type_desc
	,create_date
	,modify_date
	--,is_ms_shipped
	--,is_published
	--,is_schema_published	
	,base_object_name
FROM sys.synonyms AS sysSynonyms  

LEFT JOIN sys.schemas AS sysSchema 
	ON sysSchema.schema_id = sysSynonyms.schema_id 
	