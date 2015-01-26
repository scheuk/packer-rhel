# Installing the virtualbox guest additions
yum -y install kernel-uek-devel-3.8.13-26.2.1.el6uek.x86_64
yum -y install kernel-uek-devel-3.8.13-16.2.1.el6uek.x86_64
VBOX_VERSION=$(cat /home/packer/.vbox_version)
cd /tmp
mount -o loop /home/packer/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/packer/VBoxGuestAdditions_*.iso

