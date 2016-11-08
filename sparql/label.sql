SPARQL DEFINE sql:log-enable 3
INSERT INTO GRAPH <http://lod.kb.nl/nbt/>
{
  ?s rdfs:label ?label .
}
WHERE { GRAPH <http://lod.kb.nl/nbtpica/> { 
  ?s pica:002-/pica:002-0 ?type .
  ?s pica:021A ?blank .
  ?blank pica:021Aa ?title .
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?b, ' ; ') as ?bt {
      ?s pica:021A/pica:021Ab ?b .
    } GROUP BY ?s
  }  
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?c, ' ; ') as ?ct {
      ?s pica:021A/pica:021Ac ?c .
    } GROUP BY ?s
  }  
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?f, ' ; ') as ?ft {
      ?s pica:021A/pica:021Af ?f .
    } GROUP BY ?s
  }  
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?d, ' ; ') as ?dt {
      ?s pica:021A/pica:021Ad ?d .
    } GROUP BY ?s
  }  
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?h, ' ; ') as ?ht {
      ?s pica:021A/pica:021Ah ?h .
    } GROUP BY ?s
  }  
  OPTIONAL { 
    SELECT sql:GROUP_CONCAT (?j, ' ; ') as ?jt {
      ?s pica:021A/pica:021Aj ?j .
    } GROUP BY ?s
  }  
  BIND(CONCAT(?title, ?bt, ?ct, ?ft, ?dt, ?ht, ?jt) as ?label)
  FILTER REGEX (?type, "(^A|^O|^F|^M|^K|^I)")
}};
