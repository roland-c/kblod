## This SPARQL script converts raw pica rdf data to an alternative RDF expression

## disable checkpoints while running script
checkpoint_interval(6000);
      
## All BibliographicResources
SPARQL
DEFINE sql:log-enable 3

INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
  ?s rdf:type bibo:Document .
  ?s rdf:type dcterms:BibliographicResource . 
  ?s dc:type ?dctype .
  ?s kbo:ppn ?ppn .
  ?s dc:title ?title .
  ?s rdfs:label ?label .
  ?s kbo:tweedeTitel ?2etitle .
  ?s bf:subtitle ?2etitle .
  ?s dc:language ?taal .
  ?s bibo:isbn ?ISBN .
  ?s dcterms:description ?description .
  ?s bibo:edition ?editie .
  ?s dcterms:extent ?extent .
  ?s dcterms:alternative ?alternative .
  ?s dcterms:creator ?creatorURI .
  ?s dcterms:contributor ?contributorURI .
  ?s kbo:coCreator ?coCreatorURI .
  ?s dcterms:contributor ?secondCreatorURI .
  ?s dcterms:isPartOf ?partOfURI .
  ?s dcterms:isFormatOf ?formatOfURI .
  ?s dcterms:relation ?relation .
  ?relation dcterms:relation ?s .
  ?s dcterms:subject ?thesaurusURI .
  ?s dcterms:spatial ?spatial .
  ?s owl:sameAs ?oclcURI .
  ?s foaf:page ?link .
  ?s schema:location ?location .
  ?s kbo:shelfmark ?shelfmark .   
# PublicationEvent
  ?s schema:publication ?e .
  ?e rdf:type schema:PublicationEvent .
  ?e rdfs:label ?labelPub .
  ?e dc:publisher ?uitgever .
  ?e kbo:plaatsUitgave ?plaatsUitgave .
  ?e kbo:datumUitgave ?datumUitgave .
  }
  
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  ?s pica:002-/pica:002-0 ?type .
  ?s pica:003-/pica:003-0 ?ppn .
  OPTIONAL { ?s pica:002C/pica:002Ca ?dctype } .
  OPTIONAL { ?s pica:003-/pica:003-0 ?ppn } .
  OPTIONAL { ?s pica:021A/pica:021Aa ?title .
 	     OPTIONAL { ?s pica:021A/pica:021Ah ?stitle 
			BIND(CONCAT(" / ", ?stitle) as ?subtitle) }
	     BIND(CONCAT(?title, ?subtitle) as ?label)
	     BIND(CONCAT("Publicatie ", ?title) as ?labelPub) }  
  OPTIONAL { ?s pica:021A/pica:021Ab ?2etitle . } 
  OPTIONAL { ?s pica:021A/pica:021Ad ?subtitle . } 
  OPTIONAL { ?s pica:021A/pica:021Aj ?alternative } .
  OPTIONAL { ?s pica:010-/pica:010-a ?taal } .
  OPTIONAL { ?s pica:033A/pica:033An ?uitgever } .  
  OPTIONAL { ?s pica:033A/pica:033Ap ?plaatsUitgave } . 
  OPTIONAL { ?s pica:011-/pica:011-a ?datumUitgave } .
  OPTIONAL { ?s pica:004A/pica:004A0 ?ISBN } . 
  OPTIONAL { ?s pica:005A/pica:005A0 ?ISSN } . 
  OPTIONAL { ?s pica:003O/pica:003O0 ?OCLCnummer 
	     BIND(IRI(CONCAT("http://www.worldcat.org/oclc/", ?OCLCnummer)) as ?oclcURI) } .
  OPTIONAL { ?s pica:020A/pica:020Aa ?description } .
  OPTIONAL { ?s pica:032-/pica:032-a ?editie } .
  OPTIONAL { ?s pica:034D/pica:034Da ?extent } .
  OPTIONAL { ?s pica:028A/pica:028A9 ?creatorURI } .
  OPTIONAL { ?s pica:028B/pica:028B9 ?coCreatorURI } .
  OPTIONAL { ?s pica:028C/pica:028C9 ?secondCreatorURI } .
  OPTIONAL { ?s pica:028C ?blank .
	     ?blank pica:028Ca ?secondCreatorNameLast .
	     ?blank pica:028Cd ?secondCreatorNameFirst .
	     ?blank ev:hasOccurrence ?o .
	     BIND(CONCAT(?secondCreatorNameLast, ', ', ?secondCreatorNameFirst ) as ?secondCreatorURI) } 
  OPTIONAL { ?s pica:036D/pica:036D9 ?partOfURI }
  OPTIONAL { ?s pica:036E/pica:036E9 ?partOfURI }
  OPTIONAL { ?s pica:039M/pica:039M9 ?formatOfURI }
  OPTIONAL { ?s pica:044Z/pica:044Z9 ?thesaurusURI }
  OPTIONAL { ?s pica:045T/pica:045T9 ?thesaurusURI }
  OPTIONAL { ?s pica:045S/pica:045Sa ?thesaurusURI }
  OPTIONAL { ?s pica:045R/pica:045R9 ?thesaurusURI }
  OPTIONAL { ?s pica:045Q/pica:045Q9 ?thesaurusURI }
  OPTIONAL { ?s pica:044K/pica:044K9 ?thesaurusURI }
  OPTIONAL { ?s pica:040-/pica:040-9 ?thesaurusURI }
  OPTIONAL { ?s pica:039T/pica:039T9 ?relation }
  OPTIONAL { ?s pica:035G/pica:035Ga ?spatial .
	     ?s pica:035G/pica:035Gb ?spatial .
	     ?s pica:035G/pica:035Gc ?spatial .
	     ?s pica:035G/pica:035Gd ?spatial . }
  OPTIONAL { ?s ev:hasLocalBlock/pica:145Z/pica:145Za ?kbcode 
	     BIND(IRI(CONCAT("http://lod.kb.nl/KBCode/", REPLACE(?kbcode," ", "_"))) AS ?thesaurusURI ) } 
  OPTIONAL { ?s pica:009P/pica:009Pa ?page 
	     BIND(IRI(?page) as ?link) }
  OPTIONAL { ?s pica:009C/pica:009Ca ?loc
	     BIND(fn:substring-before(?loc, " :") as ?location) 
	     BIND(fn:substring-after(?loc, ": ") as ?shelfmark) }.
  BIND(IRI(CONCAT(str(?s), "_publication")) AS ?e)
  FILTER REGEX (?type, "(^A|^O|^F|^M|^K|^I)")

}};

## Type specification ##

## Type Book
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Book . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Aa|Ae|AF)")
}};
## Type Periodical
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Periodical . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Ab")
}};
## Type MultivolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:MultivolumeBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Ac")
}};
## Type Article
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Article . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "As")
}};

## Type E-Books
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type schema:EBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Oa|Oe)")
}};
# Periodical
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Periodical . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Ob")
}};
# MultivolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:MultivolumeBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Oc")
}};
# Article
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Article . 
   ?s rdf:type schema:EBook . 
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Of", 'i')
}};

## Type Handschriften
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Manuscript .
   ?s rdf:type kbo:Manuscript
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Fa|FF)")
}};
# MultiVolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Manuscript .
   ?s rdf:type kbo:Manuscript .
   ?s rdf:type bibo:MultivolumeBook
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Fc")
}};


## Type Bladmuziek
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:MusicalWork .
   ?s rdf:type kbo:Bladmuziek
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Ma|MF|Me|Mf)")
}};
# MultiVolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:MusicalWork .
   ?s rdf:type kbo:Bladmuziek .
   ?s rdf:type bibo:MultivolumeBook
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Mc")
}};
# Periodical
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:MusicalWork .
   ?s rdf:type kbo:Bladmuziek .
   ?s rdf:type bibo:Periodical
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Mb")
}};

## Type Kaarten
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Map .
   ?s rdf:type kbo:Kaart
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Ka|KF|Ke|Kf)")
}};
# MultiVolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Map .
   ?s rdf:type kbo:Kaart
   ?s rdf:type bibo:MultivolumeBook
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Kc")
}};
# Periodical
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Map .
   ?s rdf:type kbo:Kaart
   ?s rdf:type bibo:Periodical
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Kb")
}};

## Type Illustraties
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Image .
   ?s rdf:type dctype:Image
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "(Ia|IF|If)")
}};
# MultiVolumeBook
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s rdf:type bibo:Image .
   ?s rdf:type dctype:Image
   ?s rdf:type bibo:MultivolumeBook
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> {
   ?s pica:002-/pica:002-0 ?type .
   BIND(fn:substring(?type,1,2) as ?firstChar)
   FILTER REGEX (?firstChar, "Ic")
}};


## Data fixes ##
# fix subject link EBook from Book relation
SPARQL
DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
   ?s dcterms:subject ?subject
}
WHERE { GRAPH <http://lod.kb.nl/nbt/> { 
  ?s a schema:EBook .
  ?s dcterms:relation ?book .
  ?book dcterms:subject ?subject .
}};

## enable checkpoints while running script
checkpoint_interval(120);
