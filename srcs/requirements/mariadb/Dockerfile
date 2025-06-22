
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/mariadb-entrypoint.sh /mariadb-entrypoint.sh

RUN chmod +x ./mariadb-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./mariadb-entrypoint.sh" ]

CMD ["mysqld", "--user=mysql"]