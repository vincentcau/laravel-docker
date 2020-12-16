FROM node:12-alpine

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev

# --------------------------------------------------------- Install dependancies
RUN apk add --update --no-cache \
        # Dependancy for intl \
        icu-libs \
        libintl \
        # Dependancy for zip \
        libzip \
        # Misc tools \
        git \
        patch \
        bash \
        curl \
        gcc \
        imagemagick \
        libc-dev \
        nodejs \
        nodejs-npm \
        yarn \
        openssh-client \
        postgresql-libs \
        rsync \
        zlib-dev \
        libintl

# --------------------------------------------------- Install build dependancies
RUN apk add --update --no-cache --virtual .docker-php-global-dependancies \
        # Build dependencies for gd \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        # Build dependency for gettext \
        gettext-dev \
        # Build dependency for intl \
        icu-dev \
        # Build dependencies for XML part \
        libxml2-dev \
        ldb-dev \
        # Build dependencies for Zip \
        libzip-dev \
        # Build dependancies for Pecl \
        autoconf \
        g++ \
        make \
        # Build dependancy for APCu \
        pcre-dev \
        # Misc build dependancy \
        wget


# Install mysql
# RUN apk add --no-cache \
#    mysql \
#    mysql-client


# Install serverless
RUN npm install -g serverless --unsafe-perm=true --allow-root

# Install lerna
RUN npm install --global lerna


#install python and aws
RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py  && \
    python get-pip.py  && \
    pip install awscli

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www