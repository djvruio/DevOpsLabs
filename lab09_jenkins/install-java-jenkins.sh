#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#install updates and java open jdk 11
apt-get update -y
apt search openjdk
apt-get install -y openjdk-11-jdk
echo $(java --version)

# install git
echo "Installing git"
apt-get install git-all -y
echo $(git --version)

# install jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -y
apt-get install -y jenkins
echo $(service jenkins status)
echo "Initial Jenkins Password"
echo $(cat /var/lib/jenkins/secrets/initialAdminPassword)