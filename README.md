[![Build Status](https://circleci.com/gh/cloudify-examples/puppet-application-blueprint.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/cloudify-examples/puppet-application-blueprint)

# puppet-application-blueprint

This repository contains several blueprints for installing an application using an existing Puppet server.
It uses the Puppet architecture created in the puppet-server-example.

** Note: This repository is still in development and has no formal releases.
** Note: This repository requires > Cloudify 3.3.

## About

  * Follows the install pattern for Puppet 4.2.
  * Currently only supports installation on Ubuntu 14.04.

## Local Execution instructions

  `cp inputs/local/aws.yaml.example inputs.yaml` or
      `cp inputs/local/openstack.yaml.example inputs.yaml`

  ** Edit the inputs.yaml file with your cloud API credentials

  `cfy local init -p aws-ec2-blueprint-local.yaml -i inputs.yaml` or
      `cfy local init -p openstack-blueprint-local.yaml -i inputs.yaml`

  `cfy local execute -w install --task-retries=9`

  `cfy local outputs`
