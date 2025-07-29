#!/bin/bash

set -e

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

for instance in db1 db2 db-restore pgbackrest keyring etcd1 etcd2 etcd3; do
    incus launch images:debian/12 "$instance"
done

ansible-playbook -i hosts "$SCRIPT_DIR/cluster.yml"

echo "OpenBao root token: $(incus exec keyring -- cat /root/.vault-token)"
