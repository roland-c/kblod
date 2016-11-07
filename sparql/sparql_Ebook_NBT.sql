## This SPARQL script converts raw pica rdf data to an alternative RDF expression

## E-Books
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type dcterms:BibliographicResource . 
   ?s dc:type ?dctype .
   ?s kbo:ppn ?ppn .
   ?s rdfs:label ?label .
   ?s dcterms:title ?title .
   ?s dc:creator ?creator .
   ?s dcterms:creator ?creatorURI .
   ?s dcterms:contributor ?contributorURI .
   ?s dc:language ?taal .
   ?s bibo:isbn ?ISBN .
   ?s kbo:oclc ?OCLCnummer .
   ?s dcterms:description ?description .
   ?s bibo:edition ?editie .
   ?s dcterms:isPartOf ?partOfURI .
   ?s dcterms:isFormatOf ?formatOfURI .
   ?s dcterms:subject ?thesaurusURI .
   ?s foaf:page ?link .
   ?s dcterms:relation ?relation .
   ?s dcterms:subject ?thesaurusURI .
   ?s schema:publication ?e .
   ?e rdf:type schema:PublicationEvent .
   ?e rdfs:label ?labePub .
   ?e dc:publisher ?uitgever .
   ?e kbo:plaatsUitgave ?plaatsUitgave .
   ?e kbo:datumUitgave ?datumUitgave .
   
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   ?s pica:003-/pica:003-0 ?ppn .
   OPTIONAL { ?s pica:021A/pica:021Ah ?creator }
   OPTIONAL { ?s pica:002C/pica:002Ca ?dctype }
   OPTIONAL { ?s pica:021A/pica:021Aa ?label }
   OPTIONAL { ?s pica:021A/pica:021Aa ?title .
	      BIND(CONCAT("Publicatie ", ?title) as ?labelPub) }
   OPTIONAL { ?s pica:021A/pica:021Aa ?title .
	      ?s pica:021A/pica:021Ah ?subtitle 
 	      BIND(CONCAT(?title, " ", ?subtitle) as ?label) }    
   OPTIONAL { ?s pica:011-/pica:011-a ?datumUitgave } 
   OPTIONAL { ?s pica:010-/pica:010-a ?taal }
   OPTIONAL { ?s pica:033A/pica:033An ?uitgever } 
   OPTIONAL { ?s pica:033A/pica:033Ap ?plaatsUitgave } 
   OPTIONAL { ?s pica:004A/pica:004A0 ?ISBN } 
   OPTIONAL { ?s pica:003O/pica:003O0 ?OCLCnummer } 
   OPTIONAL { ?s pica:020A/pica:020Aa ?description } 
   OPTIONAL { ?s pica:032-/pica:032-a ?editie } 
   OPTIONAL { ?s pica:009P/pica:009Pa ?link . }
   OPTIONAL { ?s pica:028A/pica:028A9 ?creatorURI }
   OPTIONAL { ?s pica:028B/pica:028B9 ?contributorURI }
   OPTIONAL { ?s pica:039T/pica:039T9 ?relation }
   OPTIONAL { ?s ev:hasLocalBlock/pica:145Z/pica:145Za ?kbcode 
	      BIND(IRI(CONCAT("http://lod.kb.nl/KBCode/", REPLACE(?kbcode," ", "_"))) AS ?thesaurusURI ) } .
   BIND(IRI(CONCAT(str(?s), "_publication")) AS ?e)
   BIND(fn:substring(?type,1,1) as ?firstChar)
   FILTER (?firstChar = "O")
}};


## Type E-Books
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type schema:EBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Oa|Oe)")
}};

## Type Periodical
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type bibo:Periodical . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Ob")
}};

## Type MultivolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type bibo:MultivolumeBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Oc")
}};

## Type Article
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s rdf:type bibo:Article . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Of", 'i')
}};

# fix subject link EBook from Book relation
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbtlod/>
{
   ?s dcterms:subject ?subject
}
WHERE { GRAPH <http://lod.kb.nl/nbtlod/> { 
  ?s a schema:EBook .
  ?s dcterms:relation ?book .
  ?book dcterms:subject ?subject .
}};

