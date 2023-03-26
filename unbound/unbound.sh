#!/bin/bash
#DNSに現在参照しているDNSを入力、FORWARDにフォワードさせたいDNSを指定
#logは/var/log/daemon.logに出力
DNS=172.24.2.51
FORWARD=8.8.8.8

apt -y update
apt -y install unbound


touch /etc/unbound/unbound.conf.d/dns.conf
chmod +rw /etc/unbound/unbound.conf.d/dns.conf

#sed -e "s/$DNS/127.0.0.1/g" -i /etc/netplan/00-installer-config.yaml

sudo tee /etc/unbound/unbound.conf.d/dns.conf <<EOF
server:
    # Send minimum amount of information to upstream servers to enhance
    # privacy. Only sends minimum required labels of the QNAME and sets
    # QTYPE to NS when possible.

    # See RFC 7816 "DNS Query Name Minimisation to Improve Privacy" for
    # details.

    # qname-minimisation: yes

    # allow local address
    access-control: 0.0.0.0/0 allow

    # listen interface
    interface: 0.0.0.0

    # hide version
    hide-version: yes
    hide-identity: yes

    use-syslog: yes
    log-queries: yes

    local-data: "www.tmcit.sho    IN A 172.24.20.25"
#    local-data: "fuga.example.com.    IN A 172.16.0.2"
#    local-data: "foo.example.com.     IN A 172.16.0.3"
#    local-data: "bar.example.com.     IN A 172.16.0.4"


#forward-zone:
#        name: "example.org."
#        forward-addr: 192.168.10.5

forward-zone:
        name: "."
        forward-addr: 8.8.8.8
        forward-addr: 8.8.4.4


EOF


service unbound start

TT='#daemon.*'
TP='daemon.*,,,,,'

echo $TT
echo $TP

sed -e "s/$TT/$TP/g" -i /etc/rsyslog.d/50-default.conf


TT=',,,'
TP=' '
sed -e "s/$TT/$TP/g" -i /etc/rsyslog.d/50-default.conf

TT=',,'
TP='-/var/log/daemon.log'
sed -e "s%$TT% $TP %g" -i /etc/rsyslog.d/50-default.conf


service rsyslog restart

systemctl stop systemd-resolved
systemctl disable systemd-resolved
systemctl enable unbound
service unbound restart
systemctl status unbound
