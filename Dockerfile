FROM php:7.2.11-apache

RUN apt-get update && apt-get install -y curl \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  ldap-utils \
  libldap2-dev \
  libtidy-dev \
  libpng-dev \
  libzip-dev \
  zip \
  unzip \
  wget \
  inetutils-ping \
  mariadb-client-core-10.1 \
  git \
  libicu-dev \
  libfontconfig && \
  rm -rf /var/lib/apt/lists/* && \
  a2enmod rewrite && \
  docker-php-ext-install intl && \
  docker-php-ext-configure zip --with-libzip && \
  docker-php-ext-install zip && \
  docker-php-ext-install opcache && \
  docker-php-ext-install mysqli && \
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
  docker-php-ext-install gd && \
  docker-php-ext-install tidy && \
  docker-php-ext-install ldap && \
  pecl install apcu && \
  docker-php-ext-enable apcu

COPY conf/httpd.conf /etc/apache2/sites-available/000-default.conf
COPY conf/php.ini /usr/local/etc/php

WORKDIR /usr/local/bin
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  tar xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
  chmod 0755 /usr/local/bin/phantomjs && \
  rm -rf phantomjs-2.1.1-linux-x86_64.tar.bz2 phantomjs-2.1.1-linux-x86_64
