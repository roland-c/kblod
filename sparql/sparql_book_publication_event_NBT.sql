## Insert Publication Event Books
SPARQL
DEFINE sql:log-enable 3

INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
  ?s schema:publication ?e .
  ?e rdf:type schema:PublicationEvent .
  ?e rdfs:label ?label .
  ?e dc:publisher ?uitgever .
  ?e kbo:plaatsUitgave ?plaatsUitgave .
  ?e kbo:datumUitgave ?datumUitgave .
  }
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  ?s pica:002-/pica:002-0 ?type .
  ?s pica:003-/pica:003-0 ?ppn .
  OPTIONAL { ?s pica:021A/pica:021Aa ?title .
	     BIND(CONCAT("Publicatie ", ?title) as ?label) } .
  OPTIONAL { ?s pica:033A/pica:033An ?uitgever } .  
  OPTIONAL { ?s pica:033A/pica:033Ap ?plaatsUitgave } . 
  OPTIONAL { ?s pica:011-/pica:011-a ?datumUitgave } .
  BIND(IRI(CONCAT(str(?s), "_publication")) AS ?e)
  FILTER regex(str(?type), "(Aa|AA|aa|aA|Ab|Ac|Af|AF|As)", "i")
}};
