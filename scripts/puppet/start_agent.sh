#!/bin/bash

export PATH=/opt/puppetlabs/bin:$PATH
ctx logger info "Starting Puppet Agent."
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
