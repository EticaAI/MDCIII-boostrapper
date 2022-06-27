# EticaAI/lexicographi-sine-finibus automatō agentī

<!--
- https://en.wikipedia.org/wiki/Ontology_components
  - https://en.wikipedia.org/wiki/Type%E2%80%93token_distinction
    - https://en.wikipedia.org/wiki/Map%E2%80%93territory_relation
-->

## Apothēcae

> **Data per automatīs**
>
> - https://github.com/EticaAI/MDCIII-boostrapper/actions
>   - https://github.com/EticaAI/MDCIII-boostrapper

### Apothēca pūblicīs Ad GitHub 
- @MDCIII
  - https://github.com/MDCIII

### Apothēca arēnāriō Ad GitHub

Nūllus

## .ext?

| `.ext`?             |  GitHub      | Vicipaedia           |
| ------------------- | ------------------- | ------------------- |
| `.no1.owl.ttl`      |  [owl](https://github.com/topics/owl), [graph-database](https://github.com/topics/graph-database), [reasoning](https://github.com/topics/reasoning), [protege](https://github.com/topics/protege) | [Q826165 <sup>OWL</sup>](https://www.wikidata.org/wiki/Q826165) |
| `.no1.skos.ttl`     | [skos](https://github.com/topics/skos), [thesaurus](https://github.com/topics/thesaurus), [multilingual](https://github.com/topics/multilingual), [vocabularies](https://github.com/topics/vocabularies) | [Q2288360 <sup>SKOS</sup>](https://www.wikidata.org/wiki/Q2288360) |
| `.no1.tm.hxl.csv`   | [tabular-data](https://github.com/topics/tabular-data), [sql](https://github.com/topics/sql) | -- |
| `.r2rml.ttl`  |  [r2rml](https://github.com/topics/r2rml), [obda](https://github.com/topics/obda), [rml-mapping](https://github.com/topics/rml-mapping) | [Q108249512 <sup>RDF Mapping language</sup>](https://www.wikidata.org/wiki/Q108249512) | [Q108249512 <sup>RDF Mapping language</sup>](https://www.wikidata.org/wiki/Q108249512 |
| `catalog-v001.xml`  | [oasis-xml-catalogs](https://github.com/topics/oasis-xml-catalogs), [urn](https://github.com/topics/urn), [resolver](https://github.com/topics/resolver), [protege](https://github.com/topics/protege) | -- |
| `csv-metadata.json`  |  [csvw](https://github.com/topics/csvw), [linked-data](https://github.com/topics/data-package) | -- |
| `datapackage.json`  |  [frictionlessdata](https://github.com/topics/frictionlessdata), [data-package](https://github.com/topics/data-package) | -- |


<!--
@TODO need to enable some way to keep alive before 60 days passed.
      See complaints and alternatives like:
      - https://github.community/t/no-notification-workflow-disabled-after-60-days/182169
      - https://github.com/gautamkrishnar/keepalive-workflow

@TODO create an organization profile README, see
      - https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/customizing-your-organizations-profile
        - .github/profile/README.md
      - Organization picture from https://unsplash.com/photos/_YzGQvASeMk


## Project test cases
- /workspace/git/mdciii/1568346_20220619
- https://github.com/MDCIII/1568346_20220619/

## Potential tools to look
- https://github.com/SDM-TIB/SDM-RDFizer
  - https://rml.io/implementation-report/
  - https://rml.io/docs/rml/data-retrieval/
    - https://github.com/RMLio/rml-fno-test-cases

## Potential data sources
### Population
- https://github.com/datasets/population/issues/10
  - Worldbank
    - http://api.worldbank.org/v2/country/all/indicator/SP.POP.TOTL?format=jsonstat
  - https://data.worldbank.org/indicator/SP.POP.TOTL

## New formats?
- JSON stat (?): https://json-stat.org/

## Requires more tunning
- https://protegewiki.stanford.edu/wiki/Scalability_and_Tuning
  - > Projects larger than 100K frames typically required the use of the database backend. MySQL seems to give the best performance of the RDBM's that we have tested.
    - (Outdated, but exists) https://protegewiki.stanford.edu/wiki/ConvertToDBScript
  - > Ontop can (somewhat) work also with SQLite https://github.com/ontop/ontop/issues/134
    - Note to self: cli here https://ontop-vkg.org/guide/cli.html#
  - Ontop with database, turorial
    - https://ontop-vkg.org/tutorial/basic/setup.html#database-setup
      - https://ontop-vkg.org/tutorial/h2.zip -> /home/fititnt/Downloads/h2
      - jdbc:h2:~/Downloads/h2/university-session1
        - `SELECT "last_name" FROM "uni1"."academic" WHERE "position" = 1` worked
      - https://ontop-vkg.org/tutorial/basic/university.ttl
      - https://ontop-vkg.org/tutorial/basic/university.obda
      - https://ontop-vkg.org/tutorial/basic/university.properties
    - C***lho que tutorial super bacana https://ontop-vkg.org/tutorial/basic/university-1.html
      - TODO https://ontop-vkg.org/tutorial/interact/jupyter.html#sparqlwrapper
- https://www.researchgate.net/post/When-OWL-API-is-not-allowing-large-size-ontologies-then-how-we-are-going-to-handle-this-issue-for-a-large-application
  - > "Note that ontologies are more oriented to capture and model the intensional dimension of the data (the schema), instead of the actual data. I recommend you to read the works on the OWL-DL Lite segment, which allows to handle the T-BOX in memory, while storing and handling the A-BOX in an external database, providing you the scalability you might be looking for. You might find the works by Diego Calvanese and Mariano Rodríguez Muro on Query rewriting useful .
- 

```
@prefix : <http://example.org/voc#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rr: <http://www.w3.org/ns/r2rml#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<urn:uni1-student> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery "SELECT * FROM \"uni1\".\"student\""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "first_name";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:firstName
    ], [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "last_name";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:lastName
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :Student;
      rr:template "http://example.org/voc#uni1/student/{s_id}";
      rr:termType rr:IRI
    ] .

<urn:uni1-academic> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni1\".\"academic\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "first_name";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:firstName
    ], [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "last_name";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:lastName
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :FacultyMember;
      rr:template "http://example.org/uni1/academic/{a_id}";
      rr:termType rr:IRI
    ] .

<urn:uni1-course> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni1\".\"course\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "title";
          rr:termType rr:Literal
        ];
      rr:predicate :title
    ], [ a rr:PredicateObjectMap;
      rr:object <http://example.org/uni1/university>;
      rr:predicate :isGivenAt
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :Course;
      rr:template "http://example.org/uni1/course/{c_id}";
      rr:termType rr:IRI
    ] .

<urn:uni1-teaching> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni1\".\"teaching\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:template "http://example.org/uni1/course/{c_id}";
          rr:termType rr:IRI
        ];
      rr:predicate :teaches
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:template "http://example.org/uni1/academic/{a_id}";
      rr:termType rr:IRI
    ] .

<urn:uni1-registration> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni1\".\"course-registration\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:template "http://example.org/uni1/course/{c_id}";
          rr:termType rr:IRI
        ];
      rr:predicate :attends
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:template "http://example.org/uni1/student/{s_id}";
      rr:termType rr:IRI
    ] .

<urn:uni1-fullProfessor> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni1\".\"academic\"
WHERE \"position\" = 1"""
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :FullProfessor;
      rr:template "http://example.org/uni1/academic/{a_id}";
      rr:termType rr:IRI
    ] .

<urn:uni2.person> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"person\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "fname";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:firstName
    ], [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "lname";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate foaf:lastName
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class foaf:Person;
      rr:template "http://example.org/uni2/person/{pid}";
      rr:termType rr:IRI
    ] .

<urn:uni2-course> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"course\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:column "topic";
          rr:datatype xsd:string;
          rr:termType rr:Literal
        ];
      rr:predicate :title
    ], [ a rr:PredicateObjectMap;
      rr:object <http://example.org/uni2/university>;
      rr:predicate :isGivenAt
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :Course;
      rr:template "http://example.org/uni2/course/{cid}";
      rr:termType rr:IRI
    ] .

<urn:uni2-lecturer> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"course\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:template "http://example.org/uni2/course/{cid}";
          rr:termType rr:IRI
        ];
      rr:predicate :givesLecture
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:template "http://example.org/uni2/person/{lecturer}";
      rr:termType rr:IRI
    ] .

<urn:uni2-lab-teacher> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"course\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:template "http://example.org/uni2/course/{cid}";
          rr:termType rr:IRI
        ];
      rr:predicate :givesLab
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:template "http://example.org/uni2/person/{lab_teacher}";
      rr:termType rr:IRI
    ] .

<urn:uni2-registration> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"registration\""""
    ];
  rr:predicateObjectMap [ a rr:PredicateObjectMap;
      rr:objectMap [ a rr:ObjectMap, rr:TermMap;
          rr:template "http://example.org/uni2/course/{cid}";
          rr:termType rr:IRI
        ];
      rr:predicate :attends
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:template "http://example.org/uni2/person/{pid}";
      rr:termType rr:IRI
    ] .

<urn:uni2-undergraduate> a rr:TriplesMap;
  rr:logicalTable [ a rr:R2RMLView;
      rr:sqlQuery """SELECT *
FROM \"uni2\".\"person\"
WHERE \"status\" = 1"""
    ];
  rr:subjectMap [ a rr:SubjectMap, rr:TermMap;
      rr:class :UndergraduateStudent;
      rr:template "http://example.org/uni2/person/{pid}";
      rr:termType rr:IRI
    ] .

```
-->
