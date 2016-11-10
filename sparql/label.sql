SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:bt ?bt }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?b, ' ; ') as ?bt) { ?s pica:021A/pica:021Ab ?b }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:ct ?ct }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?c, ' ; ') as ?ct) { ?s pica:021A/pica:021Ac ?c }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:ft ?ft }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?f, ' ; ') as ?ft) { ?s pica:021A/pica:021Af ?f }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:dt ?dt } 
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?d, ' ; ') as ?dt) { ?s pica:021A/pica:021Ab ?d }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:ht ?ht }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?h, ' ; ') as ?ht) { ?s pica:021A/pica:021Ah ?h }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:jt ?jt }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  SELECT ?s (sql:GROUP_CONCAT (?j, ' ; ') as ?jt) { ?s pica:021A/pica:021Aj ?j }
}} GROUP BY ?s ;
SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/tmp/> { ?s kbo:title ?title . }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { ?s pica:021A/pica:021Aa ?title 
}};

SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{ ?s rdfs:label ?label . }
WHERE { GRAPH <http://lod.kb.nl/tmp/> { 
  ?s kbo:title ?title .
  OPTIONAL { ?s kbo:bt ?bt }  
  OPTIONAL { ?s kbo:ct ?ct }  
  OPTIONAL { ?s kbo:ft ?ft }  
  OPTIONAL { ?s kbo:dt ?dt }  
  OPTIONAL { ?s kbo:ht ?ht }  
  OPTIONAL { ?s kbo:jt ?jt }  
  BIND(CONCAT(?title, ' ', ?bt, ' ', ?ct, ' ', ?ft, ' ',  ?dt, ' ', ?ht, ' ', ?jt) as ?label)
}};

SPARQL DEFINE sql:log-enable 3
DELETE{ GRAPH <http://lod.kb.nl/nbt/> { 
  ?s kbo:bt ?bt
}}
WHERE { GRAPH <http://lod.kb.nl/nbt/> { 
  ?s kbo:bt ?bt
}} LIMIT 1000000;

SPARQL DEFINE sql:log-enable 3
SPARQL CLEAR GRAPH <http://lod.kb.nl/tmp/>