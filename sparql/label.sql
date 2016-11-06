SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
  ?s rdfs:label ?label .
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  ?s pica:002-/pica:002-0 ?type .
  ?s pica:021A/pica:021Aa ?title .
  OPTIONAL { ?s pica:021A/pica:021Ab ?b 
	     BIND(CONCAT(" ; ", ?b) as ?bt) }
  OPTIONAL { ?s pica:021A/pica:021Ac ?c 
	     BIND(CONCAT(" ; ", ?c) as ?ct) }
  OPTIONAL { ?s pica:021A/pica:021Af ?f 
	     BIND(CONCAT(" = ", ?f) as ?ft) }
  OPTIONAL { ?s pica:021A/pica:021Ad ?d
	     BIND(CONCAT(" : ", ?d) as ?dt) }
  OPTIONAL { ?s pica:021A/pica:021Ah ?h
	     BIND(CONCAT(" / ", ?h) as ?ht) }
  OPTIONAL { ?s pica:021A/pica:021Aj ?j
	     BIND(CONCAT(" ; ", ?j) as ?jt) }
  BIND(CONCAT(?title, ?bt, ?ct, ?ft, ?dt, ?ht, ?jt) as ?label)
  FILTER REGEX (?type, "(^A|^O|^F|^M|^K|^I)")
}};
