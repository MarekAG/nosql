#!/bin/bash

ogr2ogr -f "PostgreSQL" PG:"host=localhost dbname=postgres user=postgres password=postgres" "pedestriancrossing.geojson" -overwrite
