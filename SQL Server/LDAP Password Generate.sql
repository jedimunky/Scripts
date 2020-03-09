set nocount on;

declare @Friendlies table (given nvarchar(128), surname nvarchar(128), uid nvarchar(128));

insert into @Friendlies values ('Marshall', 'Chong', 'FPM2C');
insert into @Friendlies values ('Philip', 'Johnson', 'FPP9J');
insert into @Friendlies values ('Louise', 'Braddock', 'FPL8B');
insert into @Friendlies values ('Mark', 'Audet', 'FPM9A');
insert into @Friendlies values ('Kym', 'Stanley', 'FPK4S');
insert into @Friendlies values ('Warren', 'Conway', 'FPW6C');
insert into @Friendlies values ('Linda', 'Clark', 'FPL7C');
insert into @Friendlies values ('Irene', 'Yegon', 'FPI3Y');
insert into @Friendlies values ('Sandra', 'Clark', 'FPS4C');
insert into @Friendlies values ('Samatha', 'Light', 'FPS1L');
insert into @Friendlies values ('Faheema', 'Adat', 'FPF3A');
insert into @Friendlies values ('Emily', 'Liu', 'FPE5L');
insert into @Friendlies values ('Courtney', 'Sofield', 'FPC4S');
insert into @Friendlies values ('Teresa', 'Di Franco', 'FPT8D');
insert into @Friendlies values ('Dianne', 'Armstrong', 'FPD3A');
insert into @Friendlies values ('Sue', 'Connor', 'FPS3C');
insert into @Friendlies values ('Sarah', 'Snook', 'FPS7S');
insert into @Friendlies values ('Jocelyn', 'Sisson', 'FPJ5S');

declare @given nvarchar(128);
declare @surname nvarchar(128);
declare @uid nvarchar(128);
declare @pwd nvarchar(128);

declare FRDCSR CURSOR FOR SELECT given, surname, uid FROM @Friendlies order by uid;
OPEN FRDCSR;
FETCH NEXT FROM FRDCSR INTO @given, @surname, @uid
WHILE @@FETCH_STATUS=0
BEGIN
   
   SET @pwd = LOWER(SUBSTRING(REVERSE(CONVERT(varchar(255), NEWID())),1,8))
   
   PRINT 'dn: cn=' + @uid + ',ou=websphere_users,o=HBF,dc=com.au,c=au'
   PRINT 'objectclass: top'
   PRINT 'objectclass: person'
   PRINT 'objectclass: organizationalPerson'
   PRINT 'objectclass: inetOrgPerson'
   --PRINT 'objectclass: HBFPerson'
   PRINT 'cn: ' + @uid
   PRINT 'sn: ' + @surname
   PRINT 'uid: ' + @uid
   PRINT 'userPassword: ' + @pwd
   PRINT 'givenName: ' + @given
   PRINT 'mail: ' + @uid + '@friendlies.com.au'
   PRINT 'telephoneNumber: 0000'
   PRINT '
'  -- Need to do it this way cause PRINT '' prints a space, not a blank line
  
   FETCH NEXT FROM FRDCSR INTO @given, @surname, @uid
END;
CLOSE FRDCSR;
DEALLOCATE FRDCSR;

