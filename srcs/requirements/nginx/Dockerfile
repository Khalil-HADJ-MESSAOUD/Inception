
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
      -subj "/C=US/ST=State/L=City/O=Company/CN=localhost" \
      -newkey rsa:2048 \
      -keyout /etc/nginx/ssl/khadj-me.42.fr.key \
      -out /etc/nginx/ssl/khadj-me.42.fr.crt && \
    apt-get clean

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]