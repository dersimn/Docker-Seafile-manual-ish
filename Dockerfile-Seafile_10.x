FROM ubuntu:22.04

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
        future==0.18.* \
        mysqlclient==2.1.* \
        pymysql \
        pillow==9.3.* \
        pylibmc \
        captcha==0.4 \
        markupsafe==2.0.1 \
        jinja2 \
        sqlalchemy==1.4.3 \
        psd-tools \
        django-pylibmc \
        django_simple_captcha==0.5.* \
        djangosaml2==1.5.* \
        pysaml2==7.2.* \
        pycryptodome==3.16.* \
        cffi==1.15.1 \
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
