#!/bin/sh
#WARNING!
#DON'T DELETE THIS FILE
clear
echo "YOU WILL BOOT INTO UBUNTU IN 5 SECONDS"
echo "USERNAME: user"
echo "PASSWORD: U23rP422w0rd"
echo "MAKE SURE TO SHUTDOWN USING sudo poweroff COMMAND OR YOUR VM HAS POTENTIAL TO BREAK"
sleep 5
cd /root
qemu-system-x86_64 -drive file=/root/ubuntu-22.qcow2,format=qcow2 -drive file=/root/user-data.img,format=raw -device virtio-net-pci,netdev=n0 -netdev user,id=n0 -smp $(nproc) -m $(awk '/MemFree/ {print int($2/1024/1024)"G"}' /proc/meminfo) -accel tcg -cpu qemu64 -virtfs local,path=/qemu-share,mount_tag=shared,security_model=none,id=shared -nographic | tee /opt/KVM.log
