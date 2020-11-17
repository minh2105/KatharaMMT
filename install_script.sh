apt update
cd

echo "Installing Docker Container"
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y containerd.io docker-ce docker-ce-cli
systemctl enable docker
#Download source code Kathara
git clone https://github.com/minh2105/Install_Kathara.git

echo "Setting veriables environment"
cat >> ~/.bashrc <<EOF
export NETKIT_HOME=~/Install_Kathara/bin
export PATH=$PATH:$NETKIT_HOME
export MANPATH=:$NETKIT_HOME/man
EOF

echo "Configure proxies for docker"
mkdir -p /etc/systemd/system/docker.service.d
cat >> /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment=
EOF
systemctl daemon-reload 
systemctl restart docker

#Install Kathara
$NETKIT_HOME/install
