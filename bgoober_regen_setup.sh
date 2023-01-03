#!/bin/bash

# This is a setup and install script for a Regen Network redwood testnet node.
# Adopted from https://docs.regen.network/validators/
################################################################


# update and upgrade
sudo apt update && sudo apt upgrade -y

# install dependencies
sudo apt install git curl build-essential wget lz4 jq snap -y

# install go via snap
sudo snap install go

# add go to path
echo '
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOBIN' >> ~/.profile

# source profile
. ~/.profile

# verify go version
go version

# show go path
which go

# clone regen ledger repository
git clone https://github.com/regen-network/regen-ledger

# change directory to regen ledger
cd regen-ledger

# fetch tags
git fetch --tags

# checkout v1.0.0
git checkout v1.0.0

# make and install
make install

# check installation was successful
regen version

##### Environment variables #####
export MONIKER="Monarch" 
export CHAIN_ID=regen-redwood-1


##### Environment variables #####

# download and execute the state synce script for redwood testnet
curl -s -L https://raw.githubusercontent.com/regen-network/testnets/master/scripts/testnet-statesync.bash | bash -s $MONIKER

############## setup cosmosvisor

# change directory
cd ~

# clone cosmos sdk repository
git clone https://github.com/cosmos/cosmos-sdk

# change directory
cd cosmos-sdk

# fetch all
git fetch --all

# checkout v1.2.0
git checkout cosmovisor/v1.2.0

# build the cosmovisor binary
make cosmovisor

# copy the binary to the /go/bin directory
cp ./cosmovisor/cosmovisor $HOME/go/bin

# check cosmovisor version
cosmovisor version

# Create a cosmovisor.service systemd service file 
# make sure the environment variables are set to the desired values 
echo "[Unit]
Description=Cosmovisor daemon
After=network-online.target
[Service]
Environment="DAEMON_NAME=regen"
Environment="DAEMON_HOME=${HOME}/.regen"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_POLL_INTERVAL=300ms"
Environment="DAEMON_DATA_BACKUP_DIR=${HOME}/.regen"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="DAEMON_PREUPGRADE_MAX_RETRIES=0"
User=${USER}
ExecStart=${GOBIN}/cosmovisor run start
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
" >cosmovisor.service

# move the cosmovisor.service file to the /etc/systemd/system directory
sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service

# run the initialization command
DAEMON_HOME=~/.regen DAEMON_NAME=regen cosmovisor init $HOME/go/bin/regen

# start cosmovisor
sudo systemctl start cosmovisor

# check the status of cosmovisor
sudo systemctl status cosmovisor

# enable cosmovisor to start when the machine reboots
sudo systemctl enable cosmovisor.service

# When you make changes to the configuration...
# be sure to stop and start the cosmovisor service so that
# you are using the latest changes.
sudo systemctl stop cosmovisor
sudo systemctl daemon-reload
sudo systemctl start cosmovisor

# check the status of cosmovisor service again
sudo systemctl status cosmovisor



