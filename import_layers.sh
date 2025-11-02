#!/bin/bash

# Database credentials
DB="geoportal"
USER="admin"
PASS="admin123"
HOST="localhost"
PORT="55432"

# Path to your data folder
DATA_PATH="./spatial"

for COUNTRY_DIR in "$DATA_PATH"/*; do
  COUNTRY=$(basename "$COUNTRY_DIR")
  echo "🌍 Importing layers for $COUNTRY..."

  for FILE in "$COUNTRY_DIR"/*.shp; do
    [ -e "$FILE" ] || continue
    LAYER=$(basename "$FILE" .shp)

    echo "➡️  Importing $LAYER.shp into schema $COUNTRY"

    ogr2ogr -f "PostgreSQL" PG:"host=$HOST user=$USER dbname=$DB password=$PASS port=$PORT" \
      "$FILE" -nln "$COUNTRY.$LAYER" -nlt PROMOTE_TO_MULTI \
      -lco GEOMETRY_NAME=geom -lco FID=gid -lco SPATIAL_INDEX=GIST \
      -progress -overwrite
  done
done