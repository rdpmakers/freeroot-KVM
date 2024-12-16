#!/bin/sh

if [ ! -e $ROOTFS_DIR/.installed ]; then
  curl -L -o root.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/main.sh
fi
sh main.sh
