#!/bin/bash

# This shell script is meant for Stage 2 of the DVS Validator School Testnet Competition.

### Configuration ###

export CHAIN_ID=school-testnet-1
export KEY_NAME=M1_key

### Configuration ###

# query active governance proposals
echo "Querying governance proposals..."
gaiad query gov proposals

# vote for the proposal given config values
echo "voting for proposal..."
gaiad tx gov vote 4 Yes \
  --from=M1_key \
  --chain-id=school-testnet-1 \
  --fees=500uatom \