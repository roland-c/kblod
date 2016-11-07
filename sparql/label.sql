SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
  ?s rdfs:label ?label .
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  ?s pica:002-/pica:002-0 ?type .
  ?s pica:021A/pica:021Aa ?title .		# Main title
  OPTIONAL { ?s pica:021A/pica:021Ab ?b 
	     BIND(CONCAT(" ; ", ?b) as ?bt) }	# Second main title by the same author
  OPTIONAL { ?s pica:021A/pica:021Ac ?c 
	     BIND(CONCAT(" ; ", ?c) as ?ct) }	# Main title by another author or anonymous publication
  OPTIONAL { ?s pica:021A/pica:021Af ?f 
	     BIND(CONCAT(" = ", ?f) as ?ft) }	# Parallel title 
  OPTIONAL { ?s pica:021A/pica:021Ad ?d
	     BIND(CONCAT(" : ", ?d) as ?dt) }	# Subtitle
  OPTIONAL { ?s pica:021A/pica:021Ah ?h
	     BIND(CONCAT(" / ", ?h) as ?ht) }	# First statement of responsability
  OPTIONAL { ?s pica:021A/pica:021Aj ?j
	     BIND(CONCAT(" ; ", ?j) as ?jt) }	# Second and following statement of responsability 
  BIND(CONCAT(?title, ?bt, ?ct, ?ft, ?dt, ?ht, ?jt) as ?label)
  FILTER REGEX (?type, "(^A|^O|^F|^M|^K|^I)")
}};
