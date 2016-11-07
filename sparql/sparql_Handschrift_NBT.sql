## This SPARQL script converts raw pica rdf data to an alternative RDF expression

## Handschriften, type = first position F

SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type kbo:Manuscript . 
   ?s rdf:type dcterms:BibliographicResource . 
   ?s dc:type ?dctype .
   ?s kbo:ppn ?ppn .
   ?s rdfs:label ?label .
   ?s dcterms:title ?label .
   ?s dc:creator ?creator .
   ?s dc:language ?taal .
   ?s dc:publisher ?uitgever .
   ?s kbo:datumUitgave ?datumUitgave .
   ?s kbo:plaatsUitgave ?plaatsUitgave .
   ?s kbo:oclc ?OCLCnummer .
   ?s owl:sameAs ?oclcURI .
   ?s dcterms:description ?description .
   ?s foaf:page ?link .
   ?s dcterms:creator ?creatorURI .
   ?s dcterms:contributor ?contributorURI .
   ?s schema:location ?location .
   ?s kbo:shelfmark ?shelfmark .   
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   ?s pica:003-/pica:003-0 ?ppn .
   OPTIONAL { ?s pica:021A/pica:021Ah ?creator }
   OPTIONAL { ?s pica:002C/pica:002Ca ?dctype }
   OPTIONAL { ?s pica:021A/pica:021Aa ?label } .
   OPTIONAL { ?s pica:010-/pica:010-a ?taal }
   OPTIONAL { ?s pica:033A/pica:033An ?uitgever } 
   OPTIONAL { ?s pica:011-/pica:011-a ?datumUitgave } 
   OPTIONAL { ?s pica:033A/pica:033Ap ?plaatsUitgave } 
   OPTIONAL { ?s pica:034D/pica:034Da ?extent } .
   OPTIONAL { ?s pica:034I/pica:034Ia ?extent } .
   OPTIONAL { ?s pica:003O/pica:003O0 ?OCLCnummer 
	      BIND(CONCAT("http://www.worldcat.org/oclc/", ?OCLCnummer) as ?oclcURI) } .
   OPTIONAL { ?s pica:037A/pica:037Aa ?description } 
   OPTIONAL { ?s pica:009P/pica:009Pa ?link . }
   OPTIONAL { ?s pica:028A/pica:028A9 ?creatorURI }
   OPTIONAL { ?s pica:028B/pica:028B9 ?contributorURI }
   OPTIONAL { ?s pica:009C/pica:009Ca ?loc
	      BIND(fn:substring-before(?loc, " :") as ?location) 
	      BIND(fn:substring-after(?loc, ": ") as ?shelfmark) 
	      } .
#   FILTER REGEX(fn:substring(str(?type),1,1), "F")
   FILTER REGEX(str(?type), "(Fa|Fc|FF|Fr|Fs)")
}};
