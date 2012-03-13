#!/bin/bash
echo -e "\n**********************************************\nAdding puppet repository\n*********************************************\n\n"

echo -e "deb http://apt.puppetlabs.com/ lucid main\ndeb-src http://apt.puppetlabs.com/ lucid main" >> /etc/apt/sources.list.d/puppet.list

echo -e "\n\n*************************************\nAdding puppet repository key\n****************************************\n\n"

apt-key adv --keyserver keyserver.ubuntu.com --recv 4BD6EC30

echo -e "\n\n***********************************************\nUpdating Ubuntu repositories and Installing NTP and Puppet\n********************************************\n\n"

apt-get update && apt-get -y install ntp puppet

echo -e "\n\n*********************************************\nChanging timezone\n***********************************\n\n"
dpkg-reconfigure tzdata
service ntp restart

echo -e "\n\n*********************************************\nSetting hostname: $1\n***********************************\n\n"

hostname $1

echo -e "\n\n*********************************************\nConnecting to puppetmaster: $2\n***********************************\n\n"

puppet agent --waitforcert 60 --server $2 --test
