#!/bin/sh

# wait for Postgres instance being up and healthy
echo "Waiting for postgres..."

# loop runs until something like
# "Connection to web-db port 5432 [tcp/postgresql] succeeded!" is returned
while ! nc -z web-db 5432; do
  sleep 0.1
done

echo "PostgreSQL started"

exec "$@"