#!/bin/sh

useradd -g =uid -u 901 -s /sbin/nologin -d /var/mailserv _mailserv
echo "_mailserv   ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers

cd /var/mailserv/admin && chown -R _mailserv:_mailserv log db public tmp
cd /var/mailserv/admin/public && chown _mailserv:_mailserv javascripts stylesheets

cd /var/mailserv/account && chown -R _mailserv:_mailserv log public tmp
cd /var/mailserv/account/public && chown _mailserv:_mailserv javascripts stylesheets

#
# Making dovecot-lda deliver setuid root
# (needed for delivery to different userids)
#

touch /var/log/imap
chgrp _dovecot /usr/local/libexec/dovecot/dovecot-lda
chmod 4750 /usr/local/libexec/dovecot/dovecot-lda  
mkdir /var/mailserv/mail >/dev/null 2>&1

#
# Create custom log files for log viewer admin interface
#

touch /var/log/imap_webmin
touch /var/log/maillog_webmin
touch /var/log/messages_webmin.log

chmod 644 /var/log/imap_webmin
chmod 644 /var/log/maillog_webmin
chmod 644 /var/log/messages_webmin.log
