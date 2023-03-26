#!/bin/bash

COU=1
IP=$1
VMNUM=` expr $2 + 1`

while [ "$COU" -lt "$VMNUM" ]
do
virsh destroy ubuntu-$IP
virsh autostart --disable ubuntu-$IP
virsh undefine ubuntu-$IP
virsh vol-delete --pool default ubuntu-$IP.qcow2

virsh destroy master-k8s-ubuntu-$IP
virsh autostart --disable master-k8s-ubuntu-$IP
virsh undefine master-k8s-ubuntu-$IP
virsh vol-delete --pool default master-k8s-ubuntu-$IP.qcow2

virsh destroy worker-k8s-ubuntu-$IP
virsh autostart --disable worker-k8s-ubuntu-$IP
virsh undefine worker-k8s-ubuntu-$IP
virsh vol-delete --pool default worker-k8s-ubuntu-$IP.qcow2



let IP++
let COU++
sleep 1
done

echo "VM削除完了"
