SET NOCOUNT ON;
   
SELECT sp.name as Login, sp.sid as SID, sp2.name as Permission, spm.permission_name
FROM            sys.server_principals   AS sp
LEFT OUTER JOIN sys.server_role_members AS srm ON sp.principal_id          = srm.member_principal_id
LEFT OUTER JOIN sys.server_principals   AS sp2 ON srm.role_principal_id    = sp2.principal_id
LEFT OUTER JOIN sys.server_permissions  AS spm ON spm.grantee_principal_id = sp.principal_id
WHERE sp.type in ('U', 'S', 'G') -- Windows and Sql Logins
AND   sp.is_disabled = 0
AND   sp.name NOT LIKE 'NT SERVICE%' 
AND   sp.name NOT LIKE 'NT AUTHORITY%'
AND   sp.name <>       'NTDOMAIN\MSQLCON'
ORDER BY 1, 2, 3
;