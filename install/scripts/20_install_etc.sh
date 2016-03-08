template="/var/mailserv/install/templates"
install ${template}/fs/bin/* /usr/local/bin/
install ${template}/fs/sbin/* /usr/local/sbin/

mkdir -p /usr/local/share/mailserv 2> /dev/null
install ${template}/fs/mailserv/* /usr/local/share/mailserv

install -m 644 \
  ${template}/clamd.conf \
  ${template}/daily.local \
  ${template}/monthly.local \
  ${template}/dovecot-sql.conf \
  ${template}/freshclam.conf \
  ${template}/login.conf \
  ${template}/my.cnf \
  ${template}/newsyslog.conf \
  ${template}/profile \
  ${template}/rc.conf.local \
  ${template}/rc.shutdown \
  ${template}/rrdmon.conf \
  ${template}/syslog.conf \
  ${template}/clamav-milter.conf \
  ${template}/mx \
  /etc

install -m 644 ${template}/dovecot.conf /etc/dovecot

install -m 600 ${template}/pf.conf /etc
install -m 644 ${template}/nginx.conf /etc/nginx

install -m 644 ${template}/spamassassin_local.cf /etc/mail/spamassassin/local.cf
install -m 644 ${template}/rc.local /etc

cat <<EOF >> /etc/services
managesieve       2000/tcp            # Sieve Remote Management
mailadm           4200/tcp            # Mailserver admin port
EOF

ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3
ln -sf /usr/local/bin/python2.7-config /usr/local/bin/python-config
ln -sf /usr/local/bin/pydoc2.7  /usr/local/bin/pydoc

ln -sf /usr/local/bin/ruby18 /usr/local/bin/ruby
ln -sf /usr/local/bin/erb18 /usr/local/bin/erb
ln -sf /usr/local/bin/irb18 /usr/local/bin/irb
ln -sf /usr/local/bin/rdoc18 /usr/local/bin/rdoc
ln -sf /usr/local/bin/ri18 /usr/local/bin/ri
ln -sf /usr/local/bin/testrb18 /usr/local/bin/testrb

ln -sf /usr/local/bin/gem18 /usr/local/bin/gem
ln -sf /usr/local/bin/rake18 /usr/local/bin/rake

echo "Updating rails:"
/usr/local/bin/gem install -V -v=2.3.4 rails; 

/usr/local/bin/ruby -pi -e '$_.gsub!(/\/var\/spool\/mqueue/, "Mail queue")' /etc/daily

mkdir /etc/awstats 2>/dev/null

/usr/local/bin/ruby -pi -e '$_.gsub!(/\/usr\/local\/share\/mailserver\/sysmail.rb/, "/usr/local/share/mailserv/sysmail.rb")' /etc/mail/aliases

cat <<EOF >> /etc/mail/aliases
root: |/usr/local/share/mailserv/sysmail.rb
EOF

/usr/bin/newaliases >/dev/null 2>&1

/usr/local/bin/rake -s -f /var/mailserv/admin/Rakefile system:update_hostname RAILS_ENV=production

chgrp 0 /etc/daily.local \
        /etc/login.conf \
        /etc/monthly.local \
        /etc/pf.conf \
        /etc/rc.conf.local \
        /etc/rc.local \
        /etc/rc.shutdown \
        /etc/shells /etc/syslog.conf \
        /etc/syslog.conf

mkdir /etc/god 2>/dev/null
install -m 644 /var/mailserv/install/templates/fs/god/* /etc/god
install -m 600 /var/mailserv/install/templates/root /var/cron/tabs
install -m 644 /var/mailserv/install/templates/php-5.2.ini /etc/
