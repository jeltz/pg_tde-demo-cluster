#!/bin/bash

set -e

psql -v ON_ERROR_STOP=on "$1" <<SQL
CREATE EXTENSION pg_tde;
SQL
