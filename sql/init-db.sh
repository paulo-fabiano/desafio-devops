#!/usr/bin/env bash
set -e

APP_DB_PASSWORD="$APP_DB_PASSWORD"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

CREATE DATABASE desafio_cubos;

CREATE USER app_desafio_cubos WITH PASSWORD '$APP_DB_PASSWORD';

\c desafio_cubos

GRANT CONNECT ON DATABASE desafio_cubos TO app_desafio_cubos;
GRANT USAGE ON SCHEMA public TO app_desafio_cubos;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_desafio_cubos;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_desafio_cubos;

CREATE TABLE IF NOT EXISTS "users" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL
);

INSERT INTO "users" (username, password, role)
VALUES ('admin', 'secure_p4$$w0rd', 'admin');

EOSQL