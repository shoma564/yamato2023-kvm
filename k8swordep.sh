#!/bin/bash
cd `dirname $0`

cp -p /home/yamato/image/worker-k8s-ubuntu1.qcow2 /var/lib/libvirt/images/worker-k8s-ubuntu-$1.qcow2
cp -p /home/yamato/image/worker-k8s-ubuntu1.xml /etc/libvirt/qemu/worker-k8s-ubuntu-$1.xml

sed -e "s/ubuntu1/worker-k8s-ubuntu-$1/g" -i /etc/libvirt/qemu/worker-k8s-ubuntu-$1.xml

sed -e "s/ee1/$1/g" -i /etc/libvirt/qemu/worker-k8s-ubuntu-$1.xml



virsh define /etc/libvirt/qemu/worker-k8s-ubuntu-$1.xml



virt-edit -d worker-k8s-ubuntu-$1 /etc/rc.sh -e "s/10.254.6.221/10.254.6.$3/"
TT="--token u554jq.evc2meycntc9v8kt --discovery-token-ca-cert-hash sha256:4be2fd952d950787623e7323dceb74f3631d4d7fbe2a602ac282f922962432e4"
virt-edit -d worker-k8s-ubuntu-$1 /etc/rc.sh -e "s/$TT/$4/"
virt-edit -d worker-k8s-ubuntu-$1 /etc/netplan/00-installer-config.yaml -e "s/10.254.6.221/10.254.6.$1/"
virt-edit -d worker-k8s-ubuntu-$1 /etc/netplan/00-installer-config.yaml -e "s/192.168.1.221/192.168.1.$1/"

virt-edit -d worker-k8s-ubuntu-$1 /etc/hostname -e "s/ubuntu1/worker-k8s-ubuntu-$1/"

virsh start worker-k8s-ubuntu-$1
