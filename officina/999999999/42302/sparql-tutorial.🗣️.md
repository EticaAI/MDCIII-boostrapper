# sparql-tutorial
> - https://en.wikipedia.org/wiki/SPARQL
> - https://www.w3.org/TR/sparql11-query/
> - https://www.iana.org/assignments/media-types/application/sparql-query

## Apache Jena
> - https://jena.apache.org/documentation/query/explain.html

### EXPLAIN
```bash
qparse --explain 'SELECT * { ?s ?p ?o }'
# SELECT  *
# WHERE
#   { ?s  ?p  ?o }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (bgp (triple ?s ?p ?o))
```

### With data files
> - https://jena.apache.org/tutorials/sparql_query1.html
>  - https://github.com/MDCIII/1603_16_24/tree/main/1603/16/24/1


#### A (not working)
```bash
sparql --data=1603/16/24/1/1603_16_24_1.no1.owl.ttl --query='SELECT * { ?s ?p ?o }'
```

#### B
```bash
echo 'SELECT * { ?s ?p ?o } LIMIT 10' > /tmp/salve-mundi.rq
sparql --data=1603/16/24/1/1603_16_24_1.no1.owl.ttl --query=/tmp/salve-mundi.rq
```

#### C (remote URL)
```bash
echo 'SELECT * { ?s ?p ?o } LIMIT 10' > /tmp/salve-mundi.rq
sparql --data=https://raw.githubusercontent.com/MDCIII/1603_16_24/main/1603/16/24/1/1603_16_24_1.no1.owl.ttl --query=/tmp/salve-mundi.rq
```

#### D (local server)
```bash
echo 'SELECT * { ?s ?p ?o } LIMIT 10' > /tmp/salve-mundi.rq
sparql --data=http://127.0.0.1:1603/1603/16/24/1/1603_16_24_1.no1.owl.ttl --query=/tmp/salve-mundi.rq
```
officina/1603/16/24/1/1603_16_24_1.no1.owl.ttl

<!--
@TODO need to find latin term for debug. Previously using 
      `--venandum-insectum-est` but need to review the grammar.

- https://en.wiktionary.org/wiki/venandus#Latin
- https://en.wiktionary.org/wiki/insectum
- vēnandō, s, n, dativus, https://en.wiktionary.org/wiki/venandus#Latin
- īnsectum, s, n, nominativus, https://en.wiktionary.org/wiki/insectum
- ... /vēnandō īnsectum/@lat-Latn

- Hello world
  - salve mundi

-->
