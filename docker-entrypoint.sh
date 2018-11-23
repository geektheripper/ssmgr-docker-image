#!/bin/sh

config_file=/root/.ssmgr/deafult.yml

nohup ss-manager -m aes-256-cfb -u --manager-address 127.0.0.1:4000 &
pm2 --name "ssmgr" -f start ssmgr --no-daemon
