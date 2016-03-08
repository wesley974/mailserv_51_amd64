#!/bin/sh
/usr/local/bin/mysql_install_db > /dev/null 2>&1

/usr/local/bin/god -c /etc/god/mysql.god
sleep 10

    echo -n "  creating databases"
    unset VERSION
    /usr/local/bin/mysql -e "grant select on mail.* to 'postfix'@'localhost' identified by 'postfix';"
    /usr/local/bin/mysql -e "grant all privileges on mail.* to 'mailadmin'@'localhost' identified by 'mailadmin';"

    cd /var/mailserv/admin && /usr/local/bin/rake -s db:setup RAILS_ENV=production
    cd /var/mailserv/admin && /usr/local/bin/rake -s db:migrate RAILS_ENV=production
    /usr/local/bin/mysql mail < /var/mailserv/install/templates/sql/mail.sql
    /usr/local/bin/mysql < /var/mailserv/install/templates/sql/spamcontrol.sql
    /usr/local/bin/ruby /var/mailserv/scripts/rrdmon_create.rb
    echo "."
