FROM ubuntu:20.04

ARG S6_OVERLAY_VERSION=3.1.5.0
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        python3 \
        python3-setuptools \
        python3-pip \
        libmysqlclient-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
        django==3.2.* \
        Pillow==9.* \
        pylibmc \
        captcha \
        jinja2 \
        sqlalchemy==1.4.* \
        django-pylibmc \
        django-simple-captcha \
        mysqlclient==2.0.* \
        python3-ldap \
        pycryptodome==3.12.0 \
        cffi==1.14.0 \
        lxml

# s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# s6 services
COPY service-files /etc/s6-overlay/s6-rc.d
COPY monitor-services.sh /monitor-services

WORKDIR /seafile
CMD ["/monitor-services"]
ENTRYPOINT ["/init"]
