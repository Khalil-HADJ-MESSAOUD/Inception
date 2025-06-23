
MARIADB:
    Create users and setup the general database

NGINX:
    Change domain name to the one in subject pdf with login.42.fr

# LEARN

- [x] Learn .dockerignore
- [x] Learn my.cnf
- [x] Learn secret files usage like db_password.txt usage
- [x] Learn deeply docker composes

---

- [ ] Manage the secrets in docker compose and then update .env with value paths
- [x] Setup port 443
- [ ] (optional) adjust volume perms in vm-setup.sh
- [ ] maybe remove user creation in mariadb entrypoint script

# SETUP FOR EVAL

- install git add user to sudo
- git clone repo and exec ./vm-setup.sh
- add user to docker

---

# ENV SETUP

#MARIADB VARS
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppass

#WORDPRESS DATABASE VARS
WORDPRESS_DB_HOST=mariadb
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=wppass
WORDPRESS_DB_NAME=wordpress

#WORDPRESS CLI VARS FOR TITLE AND ADMIN
WP_SITE_TITLE=BANGER
WP_ADMIN_USER=goat
WP_ADMIN_EMAIL=goat@gmail.com
WP_ADMIN_PASSWORD=goatpw

#WORDPRESS CLI VARS FOR SUPPLEMENT USER
WP_EXTRA_USER=snitch
WP_EXTRA_EMAIL=snitch@gmail.com
WP_EXTRA_PASS=snitchpw
WP_EXTRA_ROLE=author
