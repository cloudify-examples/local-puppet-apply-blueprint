#!/bin/bash

ctx logger info "downloading deb file."
sudo wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
ctx logger info "running dpkg -i."
sudo dpkg -i puppetlabs-release-pc1-trusty.deb
ctx logger info "updating apt"
sudo apt-get update
ctx logger info "installing puppet-agent"
sudo apt-get install puppet-agent -y
