#!/bin/bash

cat ./pedestriancrossing.geojson | jq '.features[]' | jq -c '{"index": {"_type": "crossings"}}, .' > crossings3.bulk

curl -XDELETE localhost:9200/crossings

curl -s -XPUT localhost:9200/crossings/ --data-binary @crossings.mappings | jq 

curl -s -XPUT localhost:9200/crossings/_bulk --data-binary @crossings.bulk | jq
