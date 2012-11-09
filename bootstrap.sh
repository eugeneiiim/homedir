#! /bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git

rm -rf homedir
git clone git@github.com:eugeneiiim/homedir.git
shopt -s dotglob # make dotfiles moveable
rsync -a homedir/ ~
bin/setup/setup_home.sh
