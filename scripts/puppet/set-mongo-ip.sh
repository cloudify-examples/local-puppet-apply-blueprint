#!/bin/bash

MONGODB_PUBLIC_IP=$(ctx target instance runtime-properties public_ip_address)
echo "${MONGODB_PUBLIC_IP} mongodb_host" | sudo tee -a /etc/hosts
