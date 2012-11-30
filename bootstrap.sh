#! /bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git

rm -rf homedir
git config --global http.sslVerify false
git clone https://github.com/eugeneiiim/homedir
shopt -s dotglob # make dotfiles moveable
rsync -a homedir/ ~
rm -rf homedir
bin/setup/setup_home.sh
