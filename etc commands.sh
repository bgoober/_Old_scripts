#!bin/bash 

https://github.com/cosmos/testnets/raw/master/public/genesis.json.gz




broken links 

https://github.com/cosmos/testnets/tree/master/public



wget https://github.com/hyphacoop/testnets/raw/add-theta-testnet/v7-theta/public-testnet/genesis.json.gz
gzip -d genesis.json.gz
mv genesis.json $HOME/.gaia/config/genesis.json


wget https://github.com/cosmos/testnets/raw/master/public/genesis.json.gz
gzip -d genesis.json.gz
mv genesis.json $HOME/.gaia/config/genesis.json


https://github.com/hyphacoop/testnets/blob/add-theta-testnet/v7-theta/public-testnet/genesis.json.gz

# from cosmos/testnets
git clone https://github.com/hyphacoop/cosmos-ansible.git
cd cosmos-ansible
git checkout v0.1.0
ansible-playbook gaia.yml -i examples/inventory-theta.yml -e 'target=SERVER_IP_OR_DOMAIN'
