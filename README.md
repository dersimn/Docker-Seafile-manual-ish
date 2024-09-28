This package is basically a minimal Docker image to install Seafile manually. Its purpose is to install all the dependencies of Seafile (this one [here](https://manual.seafile.com/deploy/using_mysql/)) inside a Docker container, so that the host system is not polluted by the manually installed dependencies.

Advantage over the official Seafile Docker workflow:
- You keep a bit more control over the system instead of having to trust the automatic install/upgrade process.
- Easier if you want to switch to containers from a previous installation on the host system.

Disadvantage:
- You still have to manually install Seafile within the container, which seems like a tedious process.  
  ...that's why I named this repo, but I still prefer it over the official workflow.


## Build Docker Image

```
docker build -t seafos -f Dockerfile-Seafile_8.x .
docker compose -p seafile up -d
```

If you develop on an arm64 Mac, run the command with: `--platform linux/amd64` and enable Rosetta in Docker settings.


## Install

Download binaries to host once for faster testing:

On host:

```
cd downloads
wget https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_8.0.2_x86-64.tar.gz
cd ..
```

In container:

```
docker exec -it seafile-app-1 bash

tar xf /downloads/seafile-server_8.0.2_x86-64.tar.gz
seafile-server-8.0.2/setup-seafile-mysql.sh
```
(use `db` as Database hostname)

Edit `gunicorn.conf.py`:

```
bind = "0.0.0.0:8000"
```

Edit `seahub_settings.py`. This must be the domain that will be reachable from outside of any container. Seafile does redirect to this hard-coded setting! If you can't upload any files you git this setting wrong.

Seafile 8.x - 10.x

```
FILE_SERVER_ROOT = 'http://localhost:8000/seafhttp'
```

Seafile 11.x

```
FILE_SERVER_ROOT = 'http://localhost:8000/seafhttp'
SERVICE_URL = "http://localhost:8000"
CSRF_TRUSTED_ORIGINS = ["http://localhost:8000"]
```

*(Optional)* If you want to enable WebDAV  
Edit `seafdav.conf`:

```
enabled = true
share_name = /seafdav
```

After making these edits, run Seafile for one time manually to set Admin credentials:

```
seafile-server-latest/seafile.sh start
seafile-server-latest/seahub.sh start
```

Then stop it again:

```
seafile-server-latest/seahub.sh stop
seafile-server-latest/seafile.sh stop
exit
```


## Start productively

Stop installation Container:

```
docker compose -p seafile down
```

Edit `docker-compose.yml`, disable entrypoint overrides:

```yaml
# Uncomment these during install:
#tty: true
#entrypoint: bash
#command: []
```

Start up again:

```
docker compose -p seafile up -d
```

Watch progress with:

```
docker logs --tail 100 -f seafile-app-1
```


## Update to new Version

- Build new image (see upper docs)
- `docker compose -p seafile down`
- overridde entrypoint in `docker-compose.yml`
- `docker compose -p seafile up -d`

```
docker exec -it seafile-app-1 bash

tar xf /downloads/seafile-server_9.0.10_x86-64.tar.gz

seafile-server-9.0.10/upgrade/upgrade_8.0_9.0.sh
```

To be safe, start Seafile one time manually:

```
seafile-server-latest/seafile.sh start
seafile-server-latest/seahub.sh start

seafile-server-latest/seahub.sh stop
seafile-server-latest/seafile.sh stop

exit
```

- `docker compose -p seafile down`
- comment-out overrides in compose file
- `docker compose -p seafile up -d`
