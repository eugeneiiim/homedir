#! /bin/bash

git clone git@github.com:blendlabs/treat.git

HBASE_PKG=hbase-0.92.1-cdh4.0.0.tar.gz
wget http://archive.cloudera.com/cdh4/cdh/4/$HBASE_PKG
tar xzfv $HBASE_PKG

ES_PKG=elasticsearch-0.19.8
wget https://github.com/downloads/elasticsearch/elasticsearch/$ES_PKG.tar.gz
tar xvfz $ES_PKG.tar.gz
ln -s $ES_PKG elasticsearch
