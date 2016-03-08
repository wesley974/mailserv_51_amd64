#!/bin/sh
tar zxpf /var/mailserv/install/updates/roundcube081.tar.gz -C /var/www

/usr/local/bin/mysqladmin create webmail
/usr/local/bin/mysql webmail < /var/www/webmail/webmail/SQL/mysql.initial.sql
/usr/local/bin/mysql webmail -e "grant all privileges on webmail.* to 'webmail'@'localhost' identified by 'webmail'"
