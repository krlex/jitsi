#!/usr/bin/env bash

echo "Start installation common packages"
sudo apt install -y gpg gnupg2 nginx curl apt-transport-https > /dev/null
sudo apt-add-repository universe

sudo apt update > /dev/null
sudo hostnamectl set-hostname meet.example.com

sudo echo "192.168.33.10  meet.example.com" >> /etc/hosts

curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'
echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null
sudo apt update > /dev/null

sudo apt install -y jitsi-meet > /dev/null
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh

sudo echo "org.ice4j.ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS=192.168.33.10" >> sudo /etc/jitsi/videobridge/sip-communicator.properties
sudo echo "org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS=192.168.33.10" >> sudo /etc/jitsi/videobridge/sip-communicator.properties

sudo echo "DefaultLimitNOFILE=65000" >> sudo tee /etc/systemd/system.conf
sudo echo "DefaultLimitNPROC=65000" >> sudo tee /etc/systemd/system.conf
sudo echo "DefaultTasksMax=65000" >> sudo tee /etc/systemd/system.conf

sudo systemctl show --property DefaultLimitNPROC
sudo systemctl show --property DefaultLimitNOFILE
sudo systemctl show --property DefaultTasksMax
