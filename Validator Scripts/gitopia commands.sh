#!/bin/bash


curl https://rpc-dorado.fetch.ai:443/genesis | jq '.result.genesis' > ~/.fetchd/config/genesis.json


GITOPIA_MONIKER="monarch"


export GITOPIA_WALLET=/home/agent/Documents/gitopia-1.json
