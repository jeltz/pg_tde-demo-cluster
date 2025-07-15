#!/bin/bash

set -e

psql -v ON_ERROR_STOP=on "$1" <<SQL
CREATE EXTENSION pg_tde;

SELECT pg_tde_add_global_key_provider_vault_v2('global', 'http://keyring:8200', 'kv', '/var/lib/postgresql/vault-token', NULL);

SELECT pg_tde_create_key_using_global_key_provider('db-postgres-key', 'global');
SELECT pg_tde_set_key_using_global_key_provider('db-postgres-key', 'global');

ALTER DATABASE postgres SET default_table_access_method = 'tde_heap';
SQL
