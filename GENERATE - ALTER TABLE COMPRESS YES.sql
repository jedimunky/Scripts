select 'ALTER TABLE ' concat strip(tabschema) concat '.' concat tabname concat ' COMPRESS YES;'
from syscat.tables
where tabschema = 'INFOA' with ur;
