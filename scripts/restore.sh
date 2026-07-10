#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: ./scripts/restore.sh <backup-file>"
  exit 1
fi

BACKUP_FILE="$1"

DB_CONTAINER="${DB_CONTAINER:-hotel-postgres}"
DB_USER="${DB_USER:-postgres}"
RESTORE_DB="${RESTORE_DB:-hotel_booking_restore}"

docker exec "$DB_CONTAINER" \
  psql \
  -U "$DB_USER" \
  -d postgres \
  -c "DROP DATABASE IF EXISTS ${RESTORE_DB};"

docker exec "$DB_CONTAINER" \
  psql \
  -U "$DB_USER" \
  -d postgres \
  -c "CREATE DATABASE ${RESTORE_DB};"

cat "$BACKUP_FILE" | docker exec -i "$DB_CONTAINER" \
  psql \
  -U "$DB_USER" \
  -d "$RESTORE_DB"

echo "Restore completed into database: $RESTORE_DB"