#!/bin/sh

echo "This only works with OpenBSD 5.1 amd64!"
echo "Type 'yes' to continue please : \c"
read ans

if [ "$ans" != "yes" ]; then
	exit 0;
fi

for file in `ls /var/mailserv/install/scripts/*`; do
  echo $file
  $file 2>&1 | tee -a /var/log/install.log
done

/usr/local/bin/god quit

/var/mailserv/scripts/mailserv_boot.sh

echo "Update Highline"
gem install highline -v=1.6.15

echo "Load PF ruleset"
/sbin/pfctl -f /etc/pf.conf

rake -s -f /var/mailserv/admin/Rakefile  mailserv:add_admin

echo "\nInstallation complete."
echo "Please browse to port 4200 to continue setting up Mailserv.\n"
