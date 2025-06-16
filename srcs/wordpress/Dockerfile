FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-gd php-zip php-xml php-mbstring unzip curl less && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

RUN curl -fsSL https://wordpress.org/latest.tar.gz -o wp.tar.gz && \
    tar -xzf wp.tar.gz --strip-components=1 && rm wp.tar.gz && \
    chown -R www-data:www-data /var/www/html

COPY uploads.ini /etc/php/7.4/fpm/conf.d/uploads.ini

RUN mkdir -p /run/php && chown www-data:www-data /run/php

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
