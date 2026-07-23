#!/usr/bin/env bash

set -euo pipefail

DB_CONTAINER="${DB_CONTAINER:-hotel-postgres}"
DB_NAME="${DB_NAME:-hotel_booking_db}"
DB_USER="${DB_USER:-postgres}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/hotel_booking_${TIMESTAMP}.sql"

docker exec "$DB_CONTAINER" \
  pg_dump \
  -U "$DB_USER" \
  -d "$DB_NAME" \
  --clean \
  --if-exists \
  > "$BACKUP_FILE"

echo "Backup created: $BACKUP_FILE"