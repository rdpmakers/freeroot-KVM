#!/bin/sh

if [ ! -e $ROOTFS_DIR/main.sh ]; then
  curl -L -o root.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/main.sh
fi
sh main.sh
