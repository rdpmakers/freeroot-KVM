sshpass -p "asdfqwer" ssh -o StrictHostKeyChecking=no -p2222 ubuntu@localhost "wget https://raw.githubusercontent.com/rdpmakers/freeroot-KVM/refs/heads/main/vmssh-setup.sh && sh vmssh-setup.sh"
sshpass -p "asdfqwer" sftp -oBatchMode=no -P 2222 ubuntu@localhost:/home/ubuntu/ssh.key ./ssh.key
