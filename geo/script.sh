#!/bin/bash

echo '{
"type": "FeatureCollection",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
                                                                                
"features": [
' > ./result.geojson

curl -s -XGET localhost:9200/crossings/_search -d '{"from" : 0, "size" : 2000,
  "query": { "bool" : {
            "must" : {
                "match_all" : {}
            },
      "filter": {
        "geo_distance": {
          "distance":      "10km",
          "geometry.coordinates" : [-5.935708910555356,54.6012368489165]
        }
      }
    }
  }
}' | jq -c '.hits.hits[]."_source"' | sed '$!s/$/,/'  >> ./result.geojson

echo '
]
} ' >> ./result.geojson

