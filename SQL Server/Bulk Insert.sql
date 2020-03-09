BULK INSERT [dbo].[MemberProducts]
FROM 'D:\Scripts\SqlServer\RateReviewInfoPageLoad\HKDIZ40.txt'
WITH (FIELDTERMINATOR = '|'
	 ,ROWTERMINATOR   = '\n'
	 ,MAXERRORS       = 0
	 );
