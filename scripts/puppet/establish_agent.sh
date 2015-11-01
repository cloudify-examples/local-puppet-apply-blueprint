#!/bin/bash -e

codedir="/etc/puppetlabs/code"
moduledir=${codedir}/environments/production/modules
manifestsdir=${codedir}/environments/production/manifests
puppetbin="/opt/puppetlabs/bin/puppet"

PUPPET_AGENT_HOSTNAME=$(ctx source instance runtime-properties agenthostname)
set +e
sudo $puppetbin cert sign $PUPPET_AGENT_HOSTNAME
set -e

NODE_DEFINITION_FILE=$(ctx source node properties node_definition_file)
TEMPFILE=$(ctx download-resource $NODE_DEFINITION_FILE)
NODE_DEFINITION_CONTENT=$(<${TEMPFILE})
NODE_DEFINITION="node '${PUPPET_AGENT_HOSTNAME}' {
${NODE_DEFINITION_CONTENT}
}
"
echo $NODE_DEFINITION | sudo tee -a ${manifestsdir}/site.pp
