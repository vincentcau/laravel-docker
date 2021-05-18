FROM php:7.4.16-fpm-alpine

WORKDIR /srv

RUN apk add --no-cache \
        pcre \
        pcre-dev \
        openssh \
        bash \
        ca-certificates \
        git \
        icu-libs \
        unzip \
        gd \
        libjpeg-turbo-dev \
        jpeg-dev \
        libpng-dev \
        libjpeg \
        freetype-dev \
        libzip-dev \
        oniguruma \
        tzdata \
        mysql \
        mysql-client \
        zlib-dev && \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev && \
    docker-php-ext-install \
        intl \
        zip && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install bcmath && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd && \
    apk del .build-deps && \
    apk add --no-cache su-exec && \
    addgroup bar && \
    adduser -D -h /home -s /bin/sh -G bar foo && \
    echo 'PS1="Docker > php container $ "' > /home/.bashrc

COPY php.ini /usr/local/etc/php/

RUN addgroup composer && addgroup foo composer
COPY --from=composer:2.0.12 /usr/bin/composer /usr/local/bin/composer
RUN chgrp composer /usr/local/bin/composer

RUN su-exec foo composer global require "pyrech/composer-changelogs"

COPY entrypoint.sh /sbin/entrypoint
RUN chmod +x /sbin/entrypoint

ENTRYPOINT ["entrypoint"]
