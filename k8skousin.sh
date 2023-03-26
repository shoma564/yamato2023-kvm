#!/bin/bash
cp -fvp /var/lib/libvirt/images/ubuntu1.qcow2 /home/yamato/master-k8s-ubuntu1.qcow2
virsh dumpxml ubuntu1 > /home/yamato/master-k8s-ubuntu1.xml
