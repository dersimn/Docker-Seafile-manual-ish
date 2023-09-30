FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        pkg-config \
        python3 \
        python3-setuptools \
        python3-pip \
        libmemcached-dev \
        libmysqlclient-dev \
        # Extended
        #openjdk-8-jre \
        #libreoffice-script-provider-python \
        #libreoffice \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
        Pillow==9.* \
        pylibmc \
        captcha \
        jinja2 \
        sqlalchemy \
        django-pylibmc \
        django-simple-captcha \
        python3-ldap \
        future \
        mysqlclient
        # Extended
        #django \
        #pymysql \
        #markupsafe \
        #psd-tools \
        #lxml

WORKDIR /seafile
