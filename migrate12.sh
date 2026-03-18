#!/usr/bin/bash

set -euo pipefail

POSTGRES_USER=$1
OLD_VOL=$2
NEW_VOL=$3

docker build -t tianon/postgres-upgrade:12-to-18 12-to-18

docker volume create "$NEW_VOL"

docker run --rm \
  --mount type=volume,src="$OLD_VOL",dst=/var/lib/postgresql/12/data \
  --mount type=volume,src="$NEW_VOL",dst=/var/lib/postgresql/18/docker \
  -e PGDATAOLD=/var/lib/postgresql/12/data \
  -e PGDATANEW=/var/lib/postgresql/18/docker \
  -e POSTGRES_INITDB_ARGS="--no-data-checksums -U $POSTGRES_USER" \
  tianon/postgres-upgrade:12-to-18 \
  --username="$POSTGRES_USER"
