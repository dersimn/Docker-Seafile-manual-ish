## Docker Environment

```
docker compose -p seafile down
docker compose -p seafile up -d
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
apt install python3 python3-setuptools python3-pip libmemcached-dev zlib1g-dev libmysqlclient-dev
pip3 install Pillow pylibmc captcha jinja2 sqlalchemy django-pylibmc django-simple-captcha python3-ldap future mysqlclient
```

Requirements according to [install script for 8.x](https://github.com/haiwen/seafile-server-installer) and [manual](https://manual.seafile.com/deploy/using_mysql/) (merged):

```
apt update
apt install python3 python3-setuptools python3-pip openjdk-8-jre libreoffice-script-provider-python libreoffice libmysqlclient-dev libmemcached-dev
pip3 install django==2.2.* future mysqlclient pymysql Pillow pylibmc captcha markupsafe==2.0.1 jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha python3-ldap lxml
```

Requirements according to [install script for 9.x](https://github.com/haiwen/seafile-server-installer) and [manual](https://manual.seafile.com/deploy/using_mysql/) (merged):

```
apt update
apt install python3 python3-setuptools python3-pip openjdk-8-jre libreoffice-script-provider-python libreoffice libmysqlclient-dev libmemcached-dev
pip3 install django==3.2.* future mysqlclient pymysql Pillow pylibmc captcha markupsafe==2.0.1 jinja2 sqlalchemy==1.4.3 psd-tools django-pylibmc django-simple-captcha pycryptodome==3.12.0 cffi==1.14.0 lxml python3-ldap 
```

## Install

```
docker exec -it seafile-app-1 bash
wget https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_8.0.4_x86-64.tar.gz
tar xf seafile-server_8.0.4_x86-64.tar.gz
mkdir installed
mv seafile-server_8.0.4_x86-64.tar.gz installed
cd seafile-server-8.0.4
./setup-seafile-mysql.sh
```

## After install

Edit `gunicorn.conf.py`:

```
bind = "0.0.0.0:8000"
```

Edit `seahub_settings.py`:

```
FILE_SERVER_ROOT = 'http://10.1.1.151/seafhttp'
```

Edit `seafdav.conf`:

```
enabled = true
share_name = /seafdav
```

## Start

```
cd /seafile/seafile-server-latest
./seafile.sh start
./seahub.sh start
```
