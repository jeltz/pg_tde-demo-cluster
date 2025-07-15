#!/bin/bash

set -e

psql -v ON_ERROR_STOP=on "$1" <<SQL
CREATE EXTENSION pg_tde;

SELECT pg_tde_add_global_key_provider_vault_v2('global', 'http://keyring:8200', 'kv', '/var/lib/postgresql/vault-token', NULL);

SELECT pg_tde_create_key_using_global_key_provider('server-key', 'global');
SELECT pg_tde_set_server_key_using_global_key_provider('server-key', 'global');

ALTER SYSTEM SET pg_tde.wal_encrypt = on;
SQL

/lib/postgresql/17/bin/pg_ctl restart -D /var/lib/postgresql/patroni-17
