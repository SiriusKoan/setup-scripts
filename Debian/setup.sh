#!/usr/bin/env bash

# check privilege
if [ "${EUID}" -ne 0 ]
then
    echo "Please run as root"
    exit 1
fi

# Basic tools
echo "[Install Basic Tools]"
# general
apt update
apt install -y sudo vim git tmux curl wget make gcc tree jq nginx python3.9 python3-pip figlet nodejs
pip3 install httpie
# MOTD
figlet $hostname > /etc/motd
# docker
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# k8s
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl

# Shell setup
echo "[Shell Setup]"
apt install -y fish
read -p "Enter your username: " USERNAME
HOME=`eval echo ~${USERNAME}`
chsh -s `which fish` ${USERNAME}
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/omf-install
su ${USERNAME} -c "fish /tmp/omf-install --path=${HOME}/.local/share/omf --config=${HOME}/.config/omf"
su ${USERNAME} -c 'fish -c "omf install lambda"'
su ${USERNAME} -c 'fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"'
su ${USERNAME} -c 'fish -c "fisher install jorgebucaran/autopair.fish"'
su ${USERNAME} -c 'fish -c "fisher install jethrokuan/z"'
su ${USERNAME} -c 'fish -c "fisher install molyuu/x"'
git clone https://github.com/SiriusKoan/dotfiles /tmp/dotfiles
su ${USERNAME} -c "cp /tmp/dotfiles/.tmux.conf ${HOME}"
su ${USERNAME} -c "cp /tmp/dotfiles/.vimrc ${HOME}"
su ${USERNAME} -c "cp /tmp/dotfiles/.gitconfig ${HOME}"

# Done
echo "Done"

