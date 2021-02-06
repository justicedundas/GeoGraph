// delete all nodes
//MATCH (n) DETACH DELETE n; # deleting all nodes at once leads to out of memory error
// Delete in small batches
call apoc.periodic.iterate("MATCH (n) return n", "DETACH DELETE n", {batchSize:1000}) yield batches, total 
RETURN batches, total;


// delete all constraints and indices
CALL db.index.fulltext.drop('locations');
// CALL db.index.fulltext.drop('');
CALL apoc.schema.assert({},{}, true);

// create constraints and indices
CREATE CONSTRAINT location ON (n:Location) ASSERT n.id IS UNIQUE;
CREATE INDEX location_n FOR (n:Location) ON (n.name);
CREATE INDEX location_l FOR (n:Location) ON (n.location);
CREATE CONSTRAINT world ON (n:World) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT continent ON (n:Continnent) ASSERT n.id IS UNIQUE;
CREATE INDEX continent_n FOR (n:Continent) ON (n.name);
CREATE INDEX continent_g FOR (n:Continent) ON (n.geonameId);
CREATE CONSTRAINT unregion ON (n:UNRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unsubregion ON (n:UNSubRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT unintermediateregion ON (n:UNIntermediateRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT country ON (n:Country) ASSERT n.id IS UNIQUE;
CREATE INDEX country_n FOR (n:Country) ON (n.name);
CREATE INDEX country_g FOR (n:Country) ON (n.geonameId);
CREATE INDEX country_l FOR (n:Country) ON (n.location);
CREATE CONSTRAINT admin1 ON (n:Admin1) ASSERT n.id IS UNIQUE;
CREATE INDEX admin1_n FOR (n:Admin1) ON (n.name);
CREATE INDEX admin1_f FOR (n:Admin1) ON (n.fips);
CREATE INDEX admin1_p FOR (n:Admin1) ON (n.parentId);
CREATE INDEX admin1_g FOR (n:Admin1) ON (n.geonameId);
CREATE INDEX admin1_l FOR (n:Admin1) ON (n.location);
CREATE CONSTRAINT usregion ON (n:USRegion) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT usdivision ON (n:USDivision) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT admin2 ON (n:Admin2) ASSERT n.id IS UNIQUE;
CREATE INDEX admin2_f FOR (n:Admin2) ON (n.fips);
CREATE INDEX admin2_s FOR (n:Admin2) ON (n.stateFips);
CREATE INDEX admin2_g FOR (n:Admin2) ON (n.geonameId);
CREATE INDEX admin2_n FOR (n:Admin2) ON (n.name);
CREATE INDEX admin2_l FOR (n:Admin2) ON (n.location);
CREATE CONSTRAINT city ON (n:City) ASSERT n.id IS UNIQUE;
CREATE INDEX city_n FOR (n:City) ON (n.name);
CREATE INDEX city_l FOR (n:City) ON (n.location);
CREATE INDEX city_g FOR (n:City) ON (n.geonameId);


// create full text search indices
CALL db.index.fulltext.createNodeIndex('locations',['World', 'Continent', 'UNRegion', 'UNSubRegion', 'UNIntermediateRegion', 'Country', 'Admin1', 'Admin2', 'City'],['name', 'placeName', 'iso', 'iso3', 'fips', 'geonameId', 'code']);
CALL db.index.fulltext.createNodeIndex('geoids',['UNRegion', 'UNSubRegion', 'UNIntermediateRegion', 'Country', 'Admin1', 'Admin2', 'City'],['id','iso', 'iso3', 'fips', 'geonameId','code','name'], {analyzer: 'keyword'});         



// list constraints and indices
CALL db.constraints();
CALL db.indexes();