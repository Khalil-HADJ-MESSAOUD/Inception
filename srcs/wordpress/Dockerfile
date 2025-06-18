FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql php-gd php-zip php-xml php-mbstring unzip curl less && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /usr/src/wordpress && \
    curl -fsSL https://wordpress.org/latest.tar.gz -o wp.tar.gz && \
    tar -xzf wp.tar.gz -C /usr/src/wordpress --strip-components=1 && rm wp.tar.gz && \
    chown -R www-data:www-data /usr/src/wordpress

COPY uploads.ini /etc/php/7.4/fpm/conf.d/uploads.ini

COPY wordpress-entrypoint.sh /usr/local/bin/wordpress-entrypoint.sh

RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

RUN mkdir -p /run/php && chown www-data:www-data /run/php

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]

CMD ["php-fpm7.4", "-F"]
