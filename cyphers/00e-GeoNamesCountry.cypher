LOAD CSV WITH HEADERS 
FROM 'FILE:///00e-GeoNamesCountry.csv' AS row 
MERGE (c:Country:Location{id: row.id})
SET c.name = row.name, c.iso = row.iso, c.iso3 = row.iso3, c.isoNumeric = row.isoNumeric, c.geonameId = row.geonameId, c.areaSqKm = toInteger(row.areaSqKm), c.population = toInteger(row.population),
c.location = point({longitude: toFloat(row.longitude), latitude: toFloat(row.latitude)})
FOREACH (n IN v.neighbors |
  MERGE (neighbor:Country {name: n})
  MERGE (c)-[:IS_NEIGHBOR_OF]-(neighbor)
)
RETURN count(c) as Country
;
LOAD CSV WITH HEADERS 
FROM 'FILE:///00e-GeoNamesCountry.csv' AS row 
MATCH (c:Country{id: row.id})
MATCH (ct:Country{id: row.parentId})
MERGE (a)-[i:IN]->(ct)
RETURN count(i) as IN
;