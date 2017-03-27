# Opis

Użyty zbiór danych zawiera informacje o 1572 przejściach dla pieszych w Irlandii Północnej zarządzanych przez system TransportNI.

Przykładowy rekord:

```json
{ "type": "Feature",
  "properties":
    { "ITEM_TYPE_NAME": "PEDESTRIAN_CROSSING",
      "CROSSING_TYPE_NAME": "UNCONTROLLED",
      "SECTION_NAME": "7125U4668_07 - LISMORE DR2 : CDS-N TO CDS-S AT END ST.5 -  STRABANE",
      "EASTING": 233581.000000,
      "NORTHING": 393713.000000,
      "START_DATE": "16\/09\/2004 00:00:00" },
      "geometry":
        { "type": "Point",
          "coordinates": [ -7.478735536150575, 54.790177247838194 ]
        }
}
```

## Elasticsearch

Skrypt [insert.sh](../geo/insert.sh) przekształca GeoJSON (przy użyciu narzędzia jq) dodając informacje porzebne dla Bulk API. Następnie dodaje index wraz z potrzebnym mappingiem i do tak przygotowanej struktury importuje dane.

Sktypt [script.sh](../geo/script.sh) tworzy zapytanie typu "gospatial query", otrzymany wynik "w locie" przekształca do formatu GeoJSON i zapisuje do pliku [result.geojson](../geo/result.geojson).

## PostgreSQL

Do poprawnego działania skryptów należy zainstalować w systemie dodatkowe pakiety:
- [PostGIS](http://postgis.net/)
- [ogr2ogr](http://www.gdal.org/ogr2ogr.html)

W systemie Ubuntu można zrobić to wpisując w Terminalu następujące polecenia:

```bash
sudo apt install postgis
sudo apt install ogr2ogr
```

Następnie należy dodać PostGIS do używanej bazy danych:
```bash
sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" postgres  
```

W kolejnych krokach uruchamiamy skrypty o analogicznym działaniu co te dla Elasticsearch.

Skrypt [insert_postgres.sh](../geo/insert_postgres.sh) za pomocą narzędzia ogr2ogr przekształca GeoJSON w odpowiednią tabelę w bazie danych.

Skrypt [script_postgres.sh](../geo/script_postgres.sh) za pomocą PostGIS i narzędzia ogr2ogr "w locie" odpytuje bazę, przekształca zwróceone rekordy w GeoJSON i zapisuje je do pliku [result_postgres.geojson](../geo/result_postgres.geojson)
