# Upgrading from this 11.x to 12.x (official image)

Based on official instructions

- https://manual.seafile.com/12.0/setup/setup_ce_by_docker/
- https://manual.seafile.com/12.0/upgrade/upgrade_docker/

Change your volume structure to match official image:

```
docker run --rm -it -v seafile_seafile-data:/data --workdir /data busybox sh

mkdir seafile
mv * seafile
```

Edit `gunicorn.conf.py`:

```
pids_dir = '/opt/seafile/pids'
```

Start Seafile 12.x productively:

```
docker compose -f docker-compose-12.yml -p seafile up -d
```

Sometimes database is not updated right away:

```
docker exec -it seafile-app-1 bash

seafile-server-latest/seahub.sh stop
seafile-server-latest/seafile.sh stop
seafile-server-12.0.7/upgrade/upgrade_11.0_12.0.sh
exit

docker compose -f docker-compose-12.yml -p seafile down
docker compose -f docker-compose-12.yml -p seafile up -d
```
