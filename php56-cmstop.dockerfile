FROM php:5.6-fpm
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached

RUN apk --update add openssh-client make grep autoconf gcc libc-dev zlib-dev

RUN cd /tmp \
    && curl -o php-memcache.tgz http://pecl.php.net/get/memcache-3.0.8.tgz \
    && tar -xzvf php-memcache.tgz \
    && cd memcache-3.0.8 \
    && curl -o memcache-faulty-inline.patch http://git.alpinelinux.org/cgit/aports/plain/main/php5-memcache/memcache-faulty-inline.patch?h=3.4-stable \
    && patch -p1 -i memcache-faulty-inline.patch \
    && phpize \
    && ./configure --prefix=/usr \
    && make INSTALL_ROOT=/ install \
    && install -d ./etc/php/conf.d \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini