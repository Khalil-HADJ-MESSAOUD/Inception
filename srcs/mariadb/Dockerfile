
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x ./docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./docker-entrypoint.sh" ]

CMD ["mysqld", "--user=mysql"]