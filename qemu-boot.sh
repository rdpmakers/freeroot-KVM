#!/bin/sh
#WARNING!
#DON'T DELETE THIS FILE
cd /root
qemu-system-x86_64 -drive file=/root/ubuntu-22.qcow2,format=qcow2 -drive file=/root/user-data.img,format=raw -device virtio-net-pci,netdev=n0 -netdev user,id=n0,hostfwd=tcp::2222-:22,hostfwd=udp::2222-:22 -smp $(nproc) -m $(awk '/MemFree/ {print int($2/1024/1024)"G"}' /proc/meminfo) -accel tcg -cpu qemu64 -nographic | tee /opt/KVM.log
