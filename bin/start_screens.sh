#! /bin/bash

killall screen

screen -dmS htop htop
screen -dmS edit bash -c 'cd ~treat; emacsclient -t'
screen -dmS services bash -c 'cd ~/treat; bin/run-services.py'
screen -dmS web ~/treat/bin/blend.sh
screen -dmS compile bash -c 'cd ~/treat; bin/watch.sh bin/compile.sh'
screen -dmS test bash -c 'cd ~/treat; bin/watch.sh bin/test.py'
