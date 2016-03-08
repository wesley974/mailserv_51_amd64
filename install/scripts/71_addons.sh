#!/bin/sh
template="/var/mailserv/install/templates"
install -m 644 ${template}/main.cf /etc/postfix
install -m 644 ${template}/client_* /etc/postfix
