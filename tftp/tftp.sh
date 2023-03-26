#!/bin/bash
apt -y update
apt-get -y update
sudo apt-get install tftpd-hpa

sed -e "s/--secure/--secure --create/g" -i /etc/default/tftpd-hpa
chown -R tftp /srv/tftp

service tftpd-hpa restart
