#!/bin/bash

set -e

incus delete -f db1 db2 pgbackrest keyring etcd1 etcd2 etcd3
