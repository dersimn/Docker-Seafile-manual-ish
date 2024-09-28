# Development

Starting manually:

```
docker start seafile-db-1 seafile-app-1 && \
    sleep 30 && \
docker exec seafile-app-1 bash -c 'seafile-server-latest/seafile.sh start && \
                                   seafile-server-latest/seahub.sh start'
```

```
docker exec -it seafile-app-1 bash
seafile-server-latest/seafile.sh start; seafile-server-latest/seahub.sh start
seafile-server-latest/seahub.sh stop; seafile-server-latest/seafile.sh stop
```

Stop, Clean, Start for Debugging:

```
seafile-server-latest/seahub.sh stop; seafile-server-latest/seafile.sh stop; rm -r conf/__pycache__; rm -r /tmp/*; seafile-server-latest/seafile.sh start; seafile-server-latest/seahub.sh start
```

```
docker compose -p seafile down
rm -r db-data nginx-logs seafile-data/ccnet seafile-data/conf seafile-data/logs seafile-data/pids seafile-data/seafile-data seafile-data/seahub-data; rm seafile-data/seafile-server-latest
```

Debug DB:

```
docker exec -it seafile-db-1 mysql -u root -proot
SHOW DATABASES;
```

## Requirements

Requirements minimal (tested for 8.x):

```
docker exec -it seafile-app-1 bash
apt update
```

Tested with these 2 so far:

```
apt install python3 python3-setuptools python3-pip libmemcached-dev zlib1g-dev libmysqlclient-dev
pip3 install Pillow==9.* pylibmc captcha jinja2 sqlalchemy django-pylibmc django-simple-captcha python3-ldap future mysqlclient
```

```
apt install python3 python3-setuptools python3-pip libmysqlclient-dev libmemcached-dev
pip3 install future mysqlclient Pillow==9.* pylibmc captcha jinja2 sqlalchemy django-pylibmc django-simple-captcha pycryptodome cffi lxml python3-ldap 
```

Requirements according to [install script for 8.x](https://github.com/haiwen/seafile-server-installer) and [manual](https://manual.seafile.com/deploy/using_mysql/) (merged):

```
apt update
apt install python3 python3-setuptools python3-pip openjdk-8-jre libreoffice-script-provider-python libreoffice libmysqlclient-dev libmemcached-dev
pip3 install django==2.2.* future mysqlclient pymysql Pillow==9.* pylibmc captcha markupsafe==2.0.1 jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha python3-ldap lxml
```

Requirements according to [install script for 9.x](https://github.com/haiwen/seafile-server-installer) and [manual](https://manual.seafile.com/deploy/using_mysql/) (merged):

```
apt update
apt install python3 python3-setuptools python3-pip openjdk-8-jre libreoffice-script-provider-python libreoffice libmysqlclient-dev libmemcached-dev
pip3 install django==3.2.* future mysqlclient pymysql Pillow==9.* pylibmc captcha markupsafe==2.0.1 jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha pycryptodome==3.12.0 cffi==1.14.0 lxml python3-ldap 
```
