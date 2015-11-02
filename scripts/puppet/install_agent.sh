#!/bin/bash

ctx logger info "Trying to Install Puppet Agent"

function yum_install() {
    URL=$1
    sudo rpm -ivh ${URL}
    sudo yum install puppet-agent -y
    ctx logger info "Installed Puppet Agent"
}

function apt_install() {
    URL=$1
    FILE=${URL##*/}
    sudo wget ${URL}
    sudo dpkg -i ${URL##*/}
    sudo apt-get update
    sudo apt-get install puppet-agent -y
    ctx logger info "Installed Puppet Agent"
}

if [[ -f /etc/redhat-release ]]; then
    if [[ ! -z `grep "CentOS release 6" /etc/redhat-release` ]]; then
        yum_install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
    elif [[ ! -z `grep "CentOS Linux release 7" /etc/redhat-release` ]]; then
        yum_install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    fi
elif [[ -f /etc/issue ]]; then
    if [[ ! -z `grep "Ubuntu 14.04" /etc/issue` ]]; then
        apt_install https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
    elif [[ ! -z `grep "Ubuntu 12.04" /etc/issue` ]]; then
        apt_install https://apt.puppetlabs.com/puppetlabs-release-pc1-precise.deb
    fi
else
    exit 1;
fi
