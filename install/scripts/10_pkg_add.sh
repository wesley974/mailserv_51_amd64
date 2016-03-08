#!/bin/sh

export PKG_PATH=/var/mailserv/pkgs/

echo "Installing packages"
mkdir /var/db/spamassassin 2>/dev/null
    
pkg_add git postfix-2.8.8-mysql clamav p5-Mail-SpamAssassin ruby-rails ruby-rrd ruby-mysql ruby-mongrel ruby-fastercsv ruby-highline dovecot-mysql dovecot-pigeonhole mysql-server sqlgrey nginx-1.0.11 god gtar-1.26p0 php-5.2.17p8 php-mysql-5.2.17p5 php-fastcgi-5.2.17p9
