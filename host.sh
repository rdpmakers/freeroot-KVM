#!/bin/sh
sudo export DEBIAN_FRONTEND=noninteractive
sudo apt install qemu qemu-utils qemu-system-x86 -y
if [ ! -e ./ubuntu-22.qcow2 ];then
  wget --tries=$max_retries --timeout=$timeout --no-hsts -O ubuntu-22.qcow2 https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img && wget --tries=$max_retries --timeout=$timeout --no-hsts -O user-data https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/user-data && wget --tries=$max_retries --timeout=$timeout --no-hsts -O user-data.img https://github.com/rdpmakers/freeroot-KVM/raw/refs/heads/main/user-data.img
  sudo qemu-img resize ubuntu-22.qcow2 +12G
  echo "setup done"
fi
echo "boot"
sudo qemu-system-x86_64 -drive file=ubuntu-22.qcow2,format=qcow2 -drive file=user-data.img,format=raw -device virtio-net-pci,netdev=n0 -netdev user,id=n0,hostfwd=tcp::2222-:22,hostfwd=udp::2222-:22 -smp $(nproc) -m $(awk '/MemAvailable/ {print int($2/1024/1024)"G"}' /proc/meminfo) -accel tcg -cpu qemu64 -nographic
