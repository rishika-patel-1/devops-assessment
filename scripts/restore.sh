#!/bin/bash

DB_NAME="appdb"
DB_USER="postgres"
BACKUP_FILE="backup.sql"

echo "Restoring PostgreSQL database..."

psql -U $DB_USER $DB_NAME < $BACKUP_FILE

echo "Restore completed."