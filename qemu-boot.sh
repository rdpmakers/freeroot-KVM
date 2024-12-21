#!/bin/sh
#WARNING!
#DON'T DELETE THIS FILE
qemu-system-x86_64 -drive file=ubuntu-22.qcow2,format=qcow2 -drive file=user-data.img,format=raw -device virtio-net-pci,netdev=n0 -netdev user,id=n0,hostfwd=tcp::2222-:22,hostfwd=udp::2222-:22 -smp $(nproc) -m $(awk '/MemAvailable/ {print int($2/1024/1024)"G"}' /proc/meminfo) -accel tcg -cpu qemu64 -nographic
