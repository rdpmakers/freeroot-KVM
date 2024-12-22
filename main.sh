#!/bin/bash

ROOTFS_DIR=$(pwd)
export PATH=$PATH:~/.local/usr/bin
max_retries=50
timeout=5
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  ARCH_ALT=amd64
elif [ "$ARCH" = "aarch64" ]; then
  ARCH_ALT=arm64
else
  printf "Unsupported CPU architecture: ${ARCH}"
  exit 1
fi

if [ ! -e $ROOTFS_DIR/.installed ]; then
  echo "#######################################################################################"
  echo "#"
  echo "#                          Foxytoux INSTALLER[modified by rdpmakers]"
  echo "#"
  echo "#                           Copyright (C) 2024, RecodeStudios.Cloud"
  echo "#"
  echo "#"
  echo "#######################################################################################"
  wget --tries=$max_retries --timeout=$timeout --no-hsts -O /tmp/rootfs.tar.gz \
    "http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.4-base-${ARCH_ALT}.tar.gz"
  tar -xf /tmp/rootfs.tar.gz -C $ROOTFS_DIR
fi

if [ ! -e $ROOTFS_DIR/.installed ]; then
  mkdir $ROOTFS_DIR/usr/local/bin -p
  wget --tries=$max_retries --timeout=$timeout --no-hsts -O $ROOTFS_DIR/usr/local/bin/proot "https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/main/proot-${ARCH}"

  while [ ! -s "$ROOTFS_DIR/usr/local/bin/proot" ]; do
    rm $ROOTFS_DIR/usr/local/bin/proot -rf
    wget --tries=$max_retries --timeout=$timeout --no-hsts -O $ROOTFS_DIR/usr/local/bin/proot "https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/main/proot-${ARCH}"

    if [ -s "$ROOTFS_DIR/usr/local/bin/proot" ]; then
      chmod 755 $ROOTFS_DIR/usr/local/bin/proot
      break
    fi

    chmod 755 $ROOTFS_DIR/usr/local/bin/proot
    sleep 1
  done

  chmod 755 $ROOTFS_DIR/usr/local/bin/proot
fi

if [ ! -e $ROOTFS_DIR/.installed ]; then
  printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" > ${ROOTFS_DIR}/etc/resolv.conf
  rm -rf /tmp/rootfs.tar.xz /tmp/sbin
  touch $ROOTFS_DIR/.installed
fi

CYAN='\e[0;36m'
WHITE='\e[0;37m'

RESET_COLOR='\e[0m'

display_gg() {
  echo -e "${WHITE}___________________________________________________${RESET_COLOR}"
  echo -e ""
  echo -e "           ${CYAN}-----> Trying To Boot Now! <----${RESET_COLOR}"
}

clear
display_gg
if [ -e $ROOTFS_DIR/root/ubuntu-22.qcow2 ]; then
    # If installed, directly run QEMU.
    if [ -e $ROOTFS_DIR/opt/KVM.log ]; then
      rm $ROOTFS_DIR/opt/KVM.log
    fi
    $ROOTFS_DIR/usr/local/bin/proot \
    --rootfs="${ROOTFS_DIR}" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf \
    /bin/bash -c "screen -dmS KVM sh /opt/qemu-boot.sh" &
    echo -e "              Booting..."
    echo -e "Remember to shutdown using sudo poweroff"
    sleep 5
    $ROOTFS_DIR/usr/local/bin/proot \
    --rootfs="${ROOTFS_DIR}" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf \
    /bin/bash /opt/ssh2qemu.sh
    
else
    # If not installed, start the installation and QEMU.
    $ROOTFS_DIR/usr/local/bin/proot \
    --rootfs="${ROOTFS_DIR}" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf \
    /bin/bash -c "export DEBIAN_FRONTEND=noninteractive && apt update && apt install --no-install-recommends curl wget screen sshpass openssh-client qemu-utils qemu-system-x86 -y && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O /opt/ssh2qemu.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/ssh2qemu.sh && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O /opt/qemu-boot.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/qemu-boot.sh && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O ubuntu-22.qcow2 https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O user-data https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/user-data && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O user-data.img https://github.com/rdpmakers/freeroot-KVM/raw/refs/heads/main/user-data.img && qemu-img resize ubuntu-22.qcow2 +12G"
    wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O $ROOTFS_DIR/connect.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/connect.sh
    /bin/bash $0
fi
