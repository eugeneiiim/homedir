#! /bin/bash

# *** Quick stuff ***

SAGI='sudo apt-get install -y'

$SAGI zsh emacs emacs-goodies-el curl ssh ruby yasnippet screen

# Oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git checkout .zshrc  # OMZ changes .zshrc -- revert it.

sudo chsh -s /bin/zsh `whoami`

# yasnippet
YDIR=~/.emacs.d/plugins/yasnippet
mkdir -p $YDIR
#git clone git://github.com/capitaomorte/yasnippet.git $YDIR/yasnippet

# yasnippet dir may already exist, so clone "manually"
cd $YDIR && \
git init && \
git remote add origin git://github.com/capitaomorte/yasnippet.git && \
git fetch && \
git branch master origin/master && \
git checkout master

# *** Slow stuff ***
$SAGI postgresql-9.1 openvpn htop man subversion screen redis-server build-essential openjdk-7-jdk maven2 rubygems

# Java
sudo update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

mkdir -p repo

cd ~
exec zsh
