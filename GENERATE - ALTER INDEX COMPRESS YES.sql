select 'ALTER INDEX ' concat strip(indschema) concat '.' concat indname concat ' COMPRESS YES;'
from syscat.indexes
where indschema = 'INFOA' with ur;
