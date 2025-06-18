
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./mariadb-entrypoint.sh /mariadb-entrypoint.sh

RUN chmod +x ./mariadb-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./mariadb-entrypoint.sh" ]

CMD ["mysqld", "--user=mysql"]