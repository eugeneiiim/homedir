#! /bin/bash

sudo apt-get install zsh ruby htop man subversion screen redis-server emacs emacs-goodies-el

# Oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git checkout .zshrc  # OMZ changes .zshrc -- revert it.

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

cd ~

# Blend
git clone git@github.com:blendlabs/treat.git

HBASE_PKG=hbase-0.92.1-cdh4.0.0.tar.gz
wget http://archive.cloudera.com/cdh4/cdh/4/$HBASE_PKG
tar xzfv $HBASE_PKG

ES_PKG=elasticsearch-0.19.8
wget https://github.com/downloads/elasticsearch/elasticsearch/$ES_PKG.tar.gz
tar xvfz $ES_PKG.tar.gz
ln -s $ES_PKG elasticsearch
