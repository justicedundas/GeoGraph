LOAD CSV WITH HEADERS
from 'FILE://00d-GeoNamesContinent.csv' as row
merge (c:Continent{id: row.id})
set c.name = row.name, c.geonameId = row.geonameId
return count(c) as Continent
;