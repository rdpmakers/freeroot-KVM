#!/bin/sh
ROOTFS_DIR=$(pwd)
if [ ! -e $ROOTFS_DIR/main.sh ]; then
  curl -L -o main.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/main.sh
fi
sh main.sh
