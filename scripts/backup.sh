#!/bin/bash

DB_NAME="appdb"
DB_USER="postgres"
BACKUP_FILE="backup.sql"

echo "Starting PostgreSQL backup..."

pg_dump -U $DB_USER $DB_NAME > $BACKUP_FILE

echo "Backup completed: $BACKUP_FILE"