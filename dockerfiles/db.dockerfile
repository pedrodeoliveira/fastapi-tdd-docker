FROM postgres:12.1-alpine

# run create.sql on init
ADD db/create_db.sql /docker-entrypoint-initdb.d