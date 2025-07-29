# Demo cluster for pg_tde

A simple demo cluster running Pecona PostgreSQL with pg_tde, Patroni, OpenBao and PgBackRest. The
cluster runs in containers managed with Incus and uses Ansible for provisioning.

## Dependecies

- Ansible
- Incus

## Getting started

The `create_cluster.sh` script will output a token which can be used to connect to OpenBao.

    ./create_cluster.sh
    incus exec "$(incus exec db1 patronictl dsn | sed -n 's/host=\(\S*\).*/\1/p')" -- sudo -u postgres psql

To create an initial backup run:

    incus exec pgbackrest -- sudo -u postgres pgbackrest --stanza=tde --type=full backup

To test a restore then run for example:

    incus exec db-restore -- sudo -u postgres pgbackrest --target-action --stanza=tde restore
touch
    incus exec db-restore -- sudo -u postgres /lib/postgresql/17/bin/pg_ctl -D /var/lib/postgresql/patroni-17 start
.partial
    incus exec db-restore -- sudo -u postgres touch /var/lib/postgresql/patroni-17/recovery.signal
