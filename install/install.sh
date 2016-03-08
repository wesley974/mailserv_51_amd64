#!/bin/sh

echo "This only works for OpenBSD 5.1 amd64!"
sleep 5

for file in `ls /var/mailserv/install/scripts/*`; do
  echo $file
  $file 2>&1 | tee -a /var/log/install.log
done

/usr/local/bin/god quit

/var/mailserv/scripts/mailserv_boot.sh

echo "All components added."

echo "Update Highline"
gem install highline -v=1.6.15

echo "Update PF"
touch /etc/badsrv
/sbin/pfctl -f /etc/pf.conf

rake -s -f /var/mailserv/admin/Rakefile  mailserv:add_admin

echo ""
echo "Installation complete."
echo ""
echo "Please browse to port 4200 to continue setting up Mailserv."
echo ""
