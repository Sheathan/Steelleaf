# Reference https://misc.flogisoft.com/bash/tip_colors_and_formatting for bash color usage
echo -e "\e[92mDownloading Image...\e[0m"
wget https://github.com/Sheathan/Steelleaf/blob/master/vzdump-qemu-2000-2020_10_09-20_52_04.vma.zst /var/lib/vz/dump
echo -e "\e[92mDownload complete, restoring template...\e[0m"
qmrestore /var/lib/vz/dump/vzdump-qemu-2000-2020_10_09-20_52_04.vma.zst 8000
echo -e "\e[92mSetting up template and deploying...\e[0m"
qm clone 8000 2000 --name TST-GW01
echo -e "\e[92mDeployment complete, waiting to boot VM...\e[0m"
sleep 10
echo -e "\e[92mCloning complete, booting..."
qm start 2000
echo -e "\e[92mWaiting 20 seconds for VM to boot...\e[0m"
sleep 20
echo -e "\e[92mConfiguring OpenWRT\e[0m"
qm guest exec 2000 uci set network.lan.ipaddr=10.0.0.1
qm guest exec 2000 uci commit
qm guest exec 2000 reboot
echo -e "\e[92mVM configured, rebooting...\e[0m"
echo -e "\e[92mConfiguration complete, access OpenWRT on 10.0.0.1 after 30 seconds\e[0m"
