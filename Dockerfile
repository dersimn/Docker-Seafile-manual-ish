FROM ubuntu

RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-setuptools \
        python3-pip \
        openjdk-8-jre \
        libreoffice-script-provider-python \
        libreoffice \
        libmysqlclient-dev \
        libmemcached-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
        django==2.2.* \
        future \
        mysqlclient \
        pymysql \
        Pillow \
        pylibmc \
        captcha \
        markupsafe==2.0.1 \
        jinja2 \
        sqlalchemy==1.4.3 \
        psd-tools \
        django-pylibmc \
        django-simple-captcha \
        python3-ldap \
        lxml

WORKDIR /seafile
