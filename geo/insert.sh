#!/bin/bash

curl -XDELETE localhost:9200/crossings

curl -s -XPUT localhost:9200/crossings/ --data-binary @crossings.mappings | jq 


curl -s -XPUT localhost:9200/crossings/_bulk --data-binary @crossings.bulk | jq
