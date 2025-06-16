FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-gd php-zip php-xml php-mbstring unzip curl less && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN curl -fsSL https://wordpress.org/latest.tar.gz -o wp.tar.gz && \
    tar -xzf wp.tar.gz --strip-components=1 && rm wp.tar.gz && \
    chown -R www-data:www-data /var/www/html

COPY uploads.ini /etc/php/7.4/fpm/conf.d/uploads.ini

RUN mkdir -p /run/php && chown www-data:www-data /run/php

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
