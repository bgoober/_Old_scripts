#!/bin/bash

# machine: ubuntu-s-2vcpu-4gb-sfo3-01

# school-testnet-1 machine
ssh -i ~/.ssh/id_rsa root@143.198.157.127


# theta-testnet-001 machine
ssh -i ~/.ssh/id_rsa root@137.184.2.12



### Ansible ###

# school-testnet-1 machine
git clone https://github.com/hyphacoop/cosmos-ansible.git
cd cosmos-ansible
git checkout v0.1.0
ansible-playbook gaia.yml -i examples/inventory-theta.yml -e target=143.198.157.127


# theta-testnet-001 machine
git clone https://github.com/hyphacoop/cosmos-ansible.git
cd cosmos-ansible
git checkout v0.1.0
ansible-playbook gaia.yml -i examples/inventory-theta.yml -e target=165.232.129.246
