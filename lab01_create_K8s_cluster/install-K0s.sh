#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
# install nginx
apt-get update
apt-get -y install nginx
# make sure nginx is started
service nginx start

wget https://github.com/k0sproject/k0sctl/releases/download/v0.12.1/k0sctl-linux-x64 && mv k0sctl-linux-x64 k0sctl && chmod 777 k0sctl