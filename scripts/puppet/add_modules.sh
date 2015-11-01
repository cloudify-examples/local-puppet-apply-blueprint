#!/bin/bash

codedir="/etc/puppetlabs/code"
moduledir=${codedir}/environments/production/modules
manifestsdir=${codedir}/environments/production/manifests
puppetbin="/opt/puppetlabs/bin/puppet"

sudo $puppetbin module install puppetlabs-mongodb
sudo $puppetbin module install stahnma-epel
# sudo $puppetbin apply -e 'include epel'
sudo $puppetbin module install puppetlabs-nodejs
sudo $puppetbin module generate $USER-nodecellar --skip-interview
sudo mv nodecellar ${moduledir}/

NODECELLAR_MANIFEST=$(ctx download-resource resources/puppet/nodecellar.pp)
sudo mv ${NODECELLAR_MANIFEST} ${moduledir}/nodecellar/manifests/init.pp
