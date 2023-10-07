FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        pkg-config \
        python3 \
        python3-setuptools \
        python3-pip \
        libmysqlclient-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
        Pillow==9.* \
        pylibmc \
        captcha \
        jinja2 \
        sqlalchemy==1.4.* \
        django-pylibmc \
        django-simple-captcha \
        mysqlclient==2.0.* \
        python3-ldap

WORKDIR /seafile
