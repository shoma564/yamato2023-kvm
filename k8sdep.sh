#!/bin/bash
cd `dirname $0`

cp -p /home/yamato/image/master-k8s-ubuntu1.qcow2 /var/lib/libvirt/images/master-k8s-ubuntu-$1.qcow2
cp -p /home/yamato/image/master-k8s-ubuntu1.xml /etc/libvirt/qemu/master-k8s-ubuntu-$1.xml

sed -e "s/ubuntu1/master-k8s-ubuntu-$1/g" -i /etc/libvirt/qemu/master-k8s-ubuntu-$1.xml

sed -e "s/ee1/$1/g" -i /etc/libvirt/qemu/master-k8s-ubuntu-$1.xml



virsh define /etc/libvirt/qemu/master-k8s-ubuntu-$1.xml

virt-edit -d master-k8s-ubuntu-$1 /etc/netplan/00-installer-config.yaml -e "s/10.254.6.221/10.254.6.$1/"
virt-edit -d master-k8s-ubuntu-$1 /etc/netplan/00-installer-config.yaml -e "s#192.168.1.221#192.168.1.$1#"
virt-edit -d master-k8s-ubuntu-$1 /etc/hostname -e "s/ubuntu1/master-k8s-ubuntu-$1/"

virsh start master-k8s-ubuntu-$1
