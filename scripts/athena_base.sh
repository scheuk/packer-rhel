sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

rm -f /etc/yum.repos.d/public-yum-ol6.repo

cat > /etc/yum.repos.d/athenarepos.repo << EOM
[OL_6.5]
name=Local OL6.5
baseurl=http://cobbler100.athenahealth.com/cobbler/ks_mirror/OL6.5-x86_64/Server
enabled=1
gpgcheck=1
metadata_expire=1m
priority=1
gpgkey=http://cobbler100.athenahealth.com/cobbler/ks_mirror/OL6.5-x86_64/RPM-GPG-KEY-oracle

[OL6.5-UEK3]
name=UEK3 repo for EL
baseurl=http://cobbler100.athenahealth.com/LocalRepo/UEK/UEK3
enabled=1
gpgcheck=0
metadata_expire=1m

[OL_6.5_Updates]
name=Local OEL 6 updates
baseurl=http://cobbler100.athenahealth.com/LocalRepo/ol-6.5-updates
enabled=1
gpgcheck=0
metadata_expire=1m
priority=1

[localepel]
name=Locally hosted packages from EPEL repo
baseurl=http://cobbler100.athenahealth.com/LocalRepo/epel-6-x86_64
enabled=1
gpgcheck=0
metadata_expire=1m

[localdag]
name=Locally hosted packages from DAG repo
baseurl=http://cobbler100.athenahealth.com/LocalRepo/dag-6-x86_64
enabled=1
gpgcheck=0
metadata_expire=1m

[athena]
name=Locally built and maintained packages
baseurl=http://cobbler100.athenahealth.com/LocalRepo/athena-6
enabled=1
gpgcheck=0
metadata_expire=1m

[localmisc]
name=Locally hosted Packages from Miscellaneous repos
baseurl=http://cobbler100.athenahealth.com/LocalRepo/misc-6
enabled=1
gpgcheck=0
metadata_expire=1m
EOM

yum -y update
yum -y install wget curl openssh-server

# Install root certificates
yum -y install ca-certificates

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

sed -i "s/^HOSTNAME=.*/HOSTNAME=oel65-vagrant.athenahealth.com/" /etc/sysconfig/network

# this dir needs to exsist from old setup
mkdir -p /export/home
