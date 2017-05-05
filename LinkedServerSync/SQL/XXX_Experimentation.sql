

-- https://technet.microsoft.com/en-us/library/ms177544(v=sql.110).aspx
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/create-synonym-transact-sql
-- https://docs.microsoft.com/en-us/sql/relational-databases/synonyms/create-synonyms


CREATE SYNONYM V_RPT_SEL_Kuenstler  
FOR CORDB2016.COR_Basic_BKB.dbo.V_RPT_SEL_Kuenstler;


CREATE SYNONYM V_RPT_SEL_KunstProvenienz  
FOR CORDB2016.COR_Basic_BKB.dbo.V_RPT_SEL_KunstProvenienz;
GO  


CREATE SYNONYM T_AP_Standort  
FOR CORDB2016.COR_Basic_BKB.dbo.T_AP_Standort;
GO  

CREATE SYNONYM T_AP_Ref_Freigabetyp  
FOR CORDB2016.COR_Basic_BKB.dbo.T_AP_Ref_Freigabetyp;
GO  

CREATE SYNONYM T_SYS_Standortrechte  
FOR CORDB2016.COR_Basic_BKB.dbo.T_SYS_Standortrechte;
GO  

CREATE SYNONYM T_AP_Gebaeude  
FOR CORDB2016.COR_Basic_BKB.dbo.T_AP_Gebaeude;
GO  

CREATE SYNONYM T_SYS_Gebaeuderechte  
FOR CORDB2016.COR_Basic_BKB.dbo.T_SYS_Gebaeuderechte;
GO  


CREATE SYNONYM T_AP_Geschoss  
FOR CORDB2016.COR_Basic_BKB.dbo.T_AP_Geschoss;
GO  

CREATE SYNONYM T_SYS_Geschossrechte  
FOR CORDB2016.COR_Basic_BKB.dbo.T_SYS_Geschossrechte;
GO  

CREATE SYNONYM T_AP_Ref_Geschosstyp  
FOR CORDB2016.COR_Basic_BKB.dbo.T_AP_Ref_Geschosstyp;
GO  


CREATE SYNONYM T_RPT_Translations  
FOR CORDB2016.COR_Basic_BKB.dbo.T_RPT_Translations;
GO  



CREATE SYNONYM sp_RPT_SEL_Raum  
FOR CORDB2016.COR_Basic_BKB.dbo.sp_RPT_SEL_Raum;
GO  

CREATE SYNONYM sp_RPT_SEL_Trakt  
FOR CORDB2016.COR_Basic_BKB.dbo.sp_RPT_SEL_Trakt;
GO  

CREATE SYNONYM sp_RPT_Report_PageFormatString  
FOR CORDB2016.COR_Basic_BKB.dbo.sp_RPT_Report_PageFormatString;
GO  


CREATE SYNONYM sp_RPT_DATA_KU_KunstlisteDetail_BKB  
FOR CORDB2016.COR_Basic_BKB.dbo.sp_RPT_DATA_KU_KunstlisteDetail_BKB;
GO  


CREATE SYNONYM sp_RPT_Report_GetUser  
FOR CORDB2016.COR_Basic_BKB.dbo.sp_RPT_Report_GetUser;
GO  


--[tfu_RPT_SEL_Geschoss]
--[tfu_RPT_SEL_Standort]
--[tfu_RPT_SEL_Alle]






-- funktioniert nicht 
--CREATE SYNONYM tfu_RPT_SEL_Geschoss  
--FOR CORDB2016.COR_Basic_BKB.dbo.tfu_RPT_SEL_Geschoss;
--GO  


/*
-- Doesn't work 
--CREATE SYNONYM nuid  
--FOR CORDB2016.COR_Basic_BKB.dbo.nuid;
--GO  


-- OK 
-- SELECT * FROM V_RPT_SEL_KunstProvenienz 


SELECT 
	 RPT_UID 
	,RPT_MDT_ID 
	,RPT_Nr 
	,RPT_Code 
	,RPT_Kurz 
	,LTRIM(RTRIM( ISNULL(RPT_Lang, '') + ' ' + ISNULL(RPT_Nr, '') )) AS RPT_Name 
	,RPT_Sort 
FROM tfu_RPT_SEL_Geschoss('0', 'de', '00000000-0000-0000-0000-000000000000', '0000') 

ORDER BY RPT_Sort
*/