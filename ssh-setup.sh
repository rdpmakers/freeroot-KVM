#!/bin/sh
ROOTFS_DIR=$(pwd)
export PATH=$PATH:~/.local/usr/bin
$ROOTFS_DIR/usr/local/bin/proot \
--rootfs="${ROOTFS_DIR}" \
-0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit \
/bin/sh -c 'sshpass -p "asdfqwer" ssh -o StrictHostKeyChecking=no -p2222 ubuntu@localhost "wget https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/vmssh-setup.sh && sh vmssh-setup.sh" && sshpass -p "asdfqwer" sftp -o StrictHostKeyChecking=no -o BatchMode=no -P 2222 ubuntu@localhost:/home/ubuntu/ssh.key ./ssh.key'
echo "you can connect root with ssh.key now"

