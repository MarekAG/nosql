#!/bin/bash

cat ./pedestriancrossing.geojson | jq '.features[]' | jq -c '{"index": {"_type": "crossings"}}, .' > crossings.bulk

curl -s -XDELETE localhost:9200/crossings > /dev/null

curl -s -XPUT localhost:9200/crossings/ --data-binary @crossings.mappings > /dev/null

curl -s -XPUT localhost:9200/crossings/_bulk --data-binary @crossings.bulk > /dev/null
