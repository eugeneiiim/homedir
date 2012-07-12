#! /bin/bash

sudo apt-get install ruby htop man subversion screen

# Oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
git checkout .zshrc  # OMZ changes .zshrc -- revert it.

# scala-mode
SMDIR=~/emacs_stuff/scala-mode
svn co http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/ $SMDIR
make -C $SMDIR

# Blend
git clone git@github.com:blendlabs/treat.git

wget http://archive.cloudera.com/cdh4/cdh/4/hbase-0.92.1-cdh4.0.0.tar.gz
tar xzfv hbase-0.92.1-cdh4.0.0.tar.gz
