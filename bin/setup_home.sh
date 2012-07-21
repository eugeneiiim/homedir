#! /bin/bash

sudo apt-get install ruby htop man subversion screen redis-server

# Oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git checkout .zshrc  # OMZ changes .zshrc -- revert it.

# scala-mode
SMDIR=~/emacs_stuff/scala-mode
svn co http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/ $SMDIR
make -C $SMDIR

# Blend
git clone git@github.com:blendlabs/treat.git

HBASE_PKG=hbase-0.92.1-cdh4.0.0.tar.gz
wget http://archive.cloudera.com/cdh4/cdh/4/$HBASE_PKG
tar xzfv $HBASE_PKG

ES_PKG=elasticsearch-0.19.8
wget https://github.com/downloads/elasticsearch/elasticsearch/$ES_PKG.tar.gz
tar xvfz $ES_PKG.tar.gz
ln -s $ES_PKG elasticsearch

# yasnippet
YDIR=~/.emacs.d/plugins
mkdir $YDIR
git clone git://github.com/capitaomorte/yasnippet.git $YDIR/yasnippet
