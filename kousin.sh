#!/bin/bash
rm /home/yamato/image/ubuntu1.qcow2
cp -fvp /var/lib/libvirt/images/ubuntu1.qcow2 /home/yamato/image/
virsh dumpxml ubuntu1 > /home/yamato/image/ubuntu1.xml
