#!/bin/bash -i

# This schell script is modified from the existing script at https://github.com/cosmos/testnets/tree/master/public#bash-script 
# It is modified to work with the DVS Posthuman Validator school-testnet-1

# The script performs the following actions:
	# Creates a new user with sudo privleges and switched to it
	# Updates system packages
	# Installs essential build tools
	# Installs Go and defines paths
	# clones gaia repository, checks out correct version, makes, and builds the binary
	# Configures chain ID and home folder
	# Initializes node_moniker on testnet chain ID
	

# The only thing you need to change is your NODE_MONIKER value; unless the branch or chain ID has changed in the meantime.

##### CONFIGURATION ###

# Don't change these
export GAIA_BRANCH=v7.0.2 # maybe change this if necessary!
export NODE_HOME=$HOME/.gaia
export BINARY=gaiad
export CHAIN_ID=school-testnet-1 # maybe change this if necessary!

# Change these values below
export NEW_USER=m1_validator
export NODE_MONIKER=M1
export KEY_NAME=M1_key
export WEBSITE=https://gorgeous-penalty-e5f.notion.site/Test-Notion-Site-d53a3f11e90a40e8a253322041d46595
export NODE_DETAILS="M1 DVS testnet validator."

##### CONFIGURATION ###

# you shouldn't need to edit anything below this

# add new user, give sudo permissions and switch to profile
echo "Adding new user: $NEW_USER and switching profiles..."
sudo adduser $NEW_USER
sudo usermod -aG sudo $NEW_USER
su - $NEW_USER
bash

# update packages
echo "Updating apt-get..."
sudo apt-get -y update && sudo apt upgrade -y 

# install build essentials and other tools
echo "Getting essentials..."
sudo apt-get install -y make gcc git build-essential ntp curl wget jq

# remove old go version
sudo rm -rvf /usr/local/go/

# download recent go version
wget https://golang.org/dl/go1.18.3.linux-amd64.tar.gz

# install go
sudo tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz

# remove unneeded installer
rm go1.18.3.linux-amd64.tar.gz

# source go
cat <<EOF >> ~/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF

# source profile
source ~/.profile

# check go version and confirm installation
go version

# clone gaia repository
echo "Getting gaia..."
git clone https://github.com/cosmos/gaia.git

# change directory
echo "cd into gaia..."
cd gaia

# checkout correct branch
echo "checkout gaia branch..."
git checkout $GAIA_BRANCH

# make and install 
echo "building gaia..."
make install

# check gaia version and successful installation
echo "***********************"
echo "INSTALLED GAIAD VERSION"
gaiad version
echo "***********************"

source ~/.profile

# configure chain ID and node_home folder
echo "configuring chain..."
$BINARY config --chain-id $CHAIN_ID --home $NODE_HOME
gaiad config --chain-id school-testnet-1 --home $HOME/.gaia

# initialize chain 
$BINARY init $NODE_MONIKER --home $NODE_HOME --chain-id=$CHAIN_ID
gaiad init M1 --chain-id school-testnet-1

# add new keys using key_name
echo "Adding keys..."
gaiad keys add $KEY_NAME
gaiad keys add M1_key

# add genesis account using key name
echo "Adding genesis account..."
gaiad add-genesis-account $KEY_NAME 1000000000uatom
gaiad add-genesis-account M1_key 1000000000uatom

# create gentx file
echo "Creating gentx file..."
gaiad gentx $KEY_NAME 1000000000uatom --output-document=gentx.json \
  --chain-id=$CHAIN_ID \
  --moniker=$NODE_MONIKER \
  --website=$WEBSITE \
  --details=$NODE_DETAILS \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \

gaiad gentx M1_key 1000000000uatom --output-document=M1-gentx.json \
  --chain-id=school-testnet-1 \
  --moniker=M1 \
  --website=https://gorgeous-penalty-e5f.notion.site/Test-Notion-Site-d53a3f11e90a40e8a253322041d46595 \
  --details="M1 test validator!" \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \

#########################################################################


# download cosmovisor
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.3.0

# make cosmovisor directories
mkdir -p $NODE_HOME/cosmovisor/genesis/bin
mkdir -p $NODE_HOME/cosmovisor/upgrades

# set up gaiad service 
echo "[Unit]
Description=Cosmos Hub daemon
After=network-online.target
[Service]
Environment="DAEMON_NAME=gaiad"
Environment="DAEMON_HOME=${HOME}/.gaia"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="RESTART=always"
Environment="RestartSec=5"
User=$USER
ExecStart=${HOME}/go/bin/cosmovisor run start
Restart=always
RestartSec=3
LimitNOFILE=infinity
LimitNPROC=infinity
[Install]
WantedBy=multi-user.target
" > cosmovisor.service

# move the service file to the system daemon, systemd
sudo mv cosmovisor.service /etc/systemd/system/$NODE_MONIKER.service

# reload systemd
echo "reload systemd..."
sudo systemctl daemon-reload

# enable and start the service
echo "starting the daemon..."
sudo systemctl enable $NODE_MONIKER.service
sudo systemctl start $NODE_MONIKER.service

# restart the system journal daemon
sudo systemctl restart systemd-journald