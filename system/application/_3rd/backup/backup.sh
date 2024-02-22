#!/bin/bash
PGPASSWORD=$3
export PGPASSWORD
pg_dump -h $1 -p 5432 -U $2 -F c -b -f "system/application/_3rd/backup/database.backup" $4
