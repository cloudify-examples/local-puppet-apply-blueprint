#!/bin/bash -e

puppetbin="/opt/puppetlabs/bin/puppet"

PUPPET_AGENT_HOSTNAME=$(ctx source instance runtime-properties agenthostname)
set +e
sudo $puppetbin cert clean $PUPPET_AGENT_HOSTNAME
set -e
