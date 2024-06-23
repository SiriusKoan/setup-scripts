#!/usr/bin/env bash

# Basic tools
echo "[Install Basic Tools]"

# general
curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install -y sudo vim git tmux curl wget make gcc tree jq nginx python3.9 python3-pip figlet nodejs httpie python3-virtualenv yq

# MOTD
read -p "Enter your hostname: " hostname
hostnamectl set-hostname $hostname
figlet $hostname > /etc/motd

# docker
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh

# k8s
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/bin/kubectl
sudo chmod +x /usr/bin/kubectl

# Shell setup
echo "[Shell Setup]"
sudo apt install -y fish
chsh -s `which fish`
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/omf-install
fish /tmp/omf-install --path=${HOME}/.local/share/omf --config=${HOME}/.config/omf
fish -c "omf install lambda"
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/autopair.fish"
fish -c "fisher install jethrokuan/z"
fish -c "fisher install molyuu/x"
git clone https://github.com/SiriusKoan/dotfiles /tmp/dotfiles
cp /tmp/dotfiles/.tmux.conf ${HOME}
cp /tmp/dotfiles/.vimrc ${HOME}
cp /tmp/dotfiles/.gitconfig ${HOME}

# Done
echo "Done"

