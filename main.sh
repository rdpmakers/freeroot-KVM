#!/bin/sh

ROOTFS_DIR=$(pwd)
export PATH=$PATH:~/.local/usr/bin
max_retries=50
timeout=5
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  ARCH_ALT=x86_64
elif [ "$ARCH" = "aarch64" ]; then
  ARCH_ALT=aarch64
else
  printf "Unsupported CPU architecture: ${ARCH}"
  exit 1
fi

if [ ! -e $ROOTFS_DIR/.installed ]; then
  echo "#######################################################################################"
  echo "#                                                                                     #"
  echo "#                                  PRoot KVM Installer                                #"
  echo "#                                                                                     #"
  echo "#                              Copyright (C) 2024, Rdpmakers.                         #"
  echo "#                                                                                     #"
  echo "#                                                                                     #"
  echo "#######################################################################################"
  wget --tries=$max_retries --timeout=$timeout --no-hsts -O /tmp/rootfs.tar.gz \
    "http://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/${ARCH_ALT}/alpine-minirootfs-3.21.3-${ARCH_ALT}.tar.gz"
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
  printf "${WHITE}___________________________________________________${RESET_COLOR}\n"
  printf "\n"
  printf "           ${CYAN}-----> Trying To Boot Now! <----${RESET_COLOR}\n\n"
  echo "https://github.com/rdpmakers/freeroot-KVM fork this if you love it"
}

clear
display_gg
if [ -e $ROOTFS_DIR/root/ubuntu-22.qcow2 ]; then
    # If installed, directly run QEMU.
    $ROOTFS_DIR/usr/local/bin/proot \
    --rootfs="${ROOTFS_DIR}" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit \
    /bin/sh /opt/start.sh
else
    # If not installed, start the installation and QEMU.
    $ROOTFS_DIR/usr/local/bin/proot \
    --rootfs="${ROOTFS_DIR}" \
    -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit \
    /bin/sh -c "apk add --update --no-cache ca-certificates bash qemu-system-x86_64 netcat-openbsd curl wget tzdata tini && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O ubuntu-22.qcow2 https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O user-data https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/user-data && wget --no-check-certificate --tries=$max_retries --timeout=$timeout --no-hsts -O user-data.img https://github.com/rdpmakers/freeroot-KVM/raw/refs/heads/main/user-data.img && qemu-img resize ubuntu-22.qcow2 +10G && wget -O /opt/start.sh https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/qemu-boot.sh && mkdir /qemu-share && /bin/sh /opt/start.sh"
fi
