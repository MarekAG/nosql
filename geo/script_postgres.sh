#!/bin/bash
rm -f result_postgres.geojson

ogr2ogr -f "GeoJSON" result_postgres.geojson PG:"host=localhost dbname=postgres user=postgres password=postgres" -sql 'SELECT *
FROM ogrgeojson
WHERE ST_Distance_Sphere(wkb_geometry, ST_MakePoint(-5.935708910555356,54.6012368489165)) <= 10000;'
