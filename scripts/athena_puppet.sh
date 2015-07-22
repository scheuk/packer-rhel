# Install Puppet

cat > /etc/yum.repos.d/athenapuppet.repo << EOM
[puppet-6]
name=Locally mirrored puppetlabs rpms (EL6)
baseurl=http://cobbler100.athenahealth.com/LocalRepo/puppetlabs-6
enabled=1
gpgcheck=0
metadata_expire=1m
EOM

yum -y install puppet facter ruby-shadow augeas-libs ruby-augeas

chkconfig yum-updatesd off

echo "environment = el6" >> /etc/puppet/puppet.conf
echo "pluginsync = true" >> /etc/puppet/puppet.conf
