#!/bin/bash

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

# change directory
echo "cd into gaia..."
cd gaia

# add new keys using key_name
echo "Adding keys..."
gaiad keys add $KEY_NAME --keyring-backend file

# add genesis account using key name
echo "Adding genesis account..."
gaiad add-genesis-account $KEY_NAME 1000000000uatom

# create gentx file
echo "Creating gentx file..."
gaiad gentx M1_key 1000000000uatom --output-document=gentx.json \
  --chain-id=$CHAIN_ID \
  --moniker=$NODE_MONIKER \
  --website=$WEBSITE \
  --details=$NODE_DETAILS \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
