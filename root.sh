#!/bin/sh
ROOTFS_DIR=$(pwd)
if [ ! -e $ROOTFS_DIR/main.sh ]; then
  wget -O main.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/main.sh
fi
chmod +x main.sh
./main.sh
