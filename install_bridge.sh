#!/bin/bash
wget http://www.softether-download.com/files/softether/v4.34-9745-rtm-2020.04.05-tree/Linux/SoftEther_VPN_Bridge/64bit_-_Intel_x64_or_AMD64/softether-vpnbridge-v4.34-9745-rtm-2020.04.05-linux-x64-64bit.tar.gz
apt update
apt install build-essential
tar -xvf soft*
cd vpnbridge
sed -i 's/default:/#default:/g' Makefile
sed -i 's/\@.\/.install.sh/#\@.\/.install.sh/g' Makefile
make
cd ..
mv vpnbridge /usr/local
rm *.tar.gz
chmod 600 /usr/local/vpnbridge/*
chmod 700 /usr/local/vpnbridge/vpnbridge
chmod 700 /usr/local/vpnbridge/vpncmd
touch /etc/systemd/system/vpnbridge.service
sudo echo "
[Unit]
Description=VPN Bridge
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/vpnbridge/vpnbridge start
ExecStop=/usr/local/vpnbridge/vpnbridge stop

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/vpnbridge.service
systemctl enable vpnbridge
systemctl start vpnbridge
