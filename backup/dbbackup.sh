#!/bin/bash

# config variables for accessing mysql
BACKUP_DIR="./backup/test-backup"
PG_USER="postgres"
PG_PASSWORD="poosan"
DB_NAME="phoenix"


export PGPASSWORD="$PG_PASSWORD"

# To create a new directory into backup directory location
# 0 */2 * * *  /dbbackup.sh   cron task

mkdir -p $BACKUP_DIR
date_format=`date +%d-%m-%Y-%T`
pg_dump -U $PG_USER -F t  $DB_NAME > $BACKUP_DIR/$date_format.sql.gz
