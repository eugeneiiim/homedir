#! /bin/bash

killall screen

screen -dmS htop htop
screen -d -m -S edit bash -c 'cd ~treat; emacsclient -t'
screen -d -m -S services bash -c 'cd ~/treat; bin/run-services.py'
screen -d -m -S web ~/treat/bin/blend.sh
screen -d -m -S compile bash -c 'cd ~/treat; bin/watch.sh bin/compile.sh'
screen -d -m -S test bash -c 'cd ~/treat; bin/watch.sh bin/test.py'
