#!/bin/bash

set -e

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
			ALTER USER $database PASSWORD '$POSTGRES_PASSWORD';
EOSQL
}

#echo "  Restoring database from backup file"
#pg_restore -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" keycloak.sql;

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Multiple databases created"
fi

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -f "/docker-entrypoint-initdb.d/02-keycloak.sql"