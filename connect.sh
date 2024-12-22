#!/bin/bash

ROOTFS_DIR=$(pwd)
$ROOTFS_DIR/usr/local/bin/proot \
--rootfs="${ROOTFS_DIR}" \
-0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf \
/bin/bash /opt/ssh2qemu.sh
