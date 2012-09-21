#! /bin/bash

sudo apt-get install zsh ruby htop man subversion screen redis-server emacs emacs-goodies-el build-essential openjdk-7-jdk maven2 curl ssh

# Oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git checkout .zshrc  # OMZ changes .zshrc -- revert it.

sudo chsh -s /bin/zsh emarinelli

# scala-mode
SMDIR=~/emacs_stuff/scala-mode
svn co http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/ $SMDIR
make -C $SMDIR

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

# Java
sudo update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java