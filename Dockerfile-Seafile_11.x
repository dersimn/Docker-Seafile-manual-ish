FROM ubuntu:22.04

ARG S6_OVERLAY_VERSION=3.1.5.0
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        dnsutils \
        curl \
        ca-certificates \
        vim \
        htop \
        net-tools \
        psmisc \
        wget \
        git \
        unzip \
        tzdata \
        fuse \
        python3 \
        python3-dev \
        python3-setuptools \
        python3-pip \
        python3-ldap \
        ldap-utils \
        libldap2-dev \
        memcached \
        libmemcached-dev \
        libsasl2-dev \
        libmysqlclient-dev \
        libmemcached11 \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
        django==4.2.* \
        future==0.18.* \
        mysqlclient==2.1.* \
        pymysql \
        pillow==10.2.* \
        pylibmc \
        captcha==0.5.* \
        markupsafe==2.0.1 \
        jinja2 \
        sqlalchemy==2.0.18 \
        psd-tools \
        django-pylibmc \
        django_simple_captcha==0.6.* \
        djangosaml2==1.5.* \
        pysaml2==7.2.* \
        pycryptodome==3.16.* \
        cffi==1.16.0 \
        lxml \
        python-ldap==3.4.3

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
