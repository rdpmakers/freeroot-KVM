sudo sed -i -E 's/^#?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i -E 's/^#?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
ssh-keygen -b 2048 -t rsa -N "" -f ssh.key
sudo sh -c "cat ssh.key.pub >> /root/.ssh/authorized_keys"
sudo systemctl reload sshd
rm vmssh-setup.sh
