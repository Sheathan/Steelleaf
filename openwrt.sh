wget https://github.com/Sheathan/Steelleaf/blob/master/vzdump-qemu-2000-2020_10_09-20_52_04.vma.zst /var/lib/vz/dump
qmrestore /var/lib/vz/dump/vzdump-qemu-2000-2020_10_09-20_52_04.vma.zst 8000
qm clone 8000 2000 --name TST-GW01
sleep 10
qm start 2000
echo "Waiting 20 seconds for VM to boot..."
sleep 20
echo "Configuring OpenWRT"
qm guest exec 2000 uci set network.lan.ipaddr=10.0.0.1
qm guest exec 2000 uci commit
qm guest exec 2000 reboot
echo "VM configured, rebooting..."
echo "Configuration complete, access OpenWRT on 10.0.0.1 after 30 seconds"
