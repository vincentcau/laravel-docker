FROM php:7.3-alpine

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
RUN apk add --no-cache \
    mysql \
    mysql-client

# Install PECL and PEAR extensions
RUN pecl install \
    imagick \
    xdebug

# Install and enable php extensions
# ------------------------------------------------------- Install php extensions
RUN php -m && \
    docker-php-ext-configure bcmath --enable-bcmath && \
    docker-php-ext-configure gd \
      --with-freetype-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/ \
      --with-png-dir=/usr/include/ && \
    docker-php-ext-configure gettext && \
    docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure mbstring --enable-mbstring && \
    docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-configure pcntl --enable-pcntl && \
    docker-php-ext-configure soap && \
    docker-php-ext-configure zip --enable-zip --with-libzip && \
    docker-php-ext-install bcmath \
        gd \
        gettext \
        intl \
        mbstring \
        opcache \
        pcntl \
        soap \
        zip && \
    php -m

# Install GD
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev


# Install serverless
RUN npm install -g serverless --unsafe-perm=true --allow-root

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

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www