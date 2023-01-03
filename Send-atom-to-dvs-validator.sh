#!/bin/bash

### Configuration ###

export KEY_NAME=M1_key
export DVS= # input DVS validator's cosmosvaloper address here
export DVS_PUB= # input DVS validator's public address here
export SEND_AMOUNT=1000000uatom
export GAS_PRICE=0.0025uatom

### Configuration ###


# DVS "delegator_address": cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv
# DVS valoper address: cosmosvaloper1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umptp7zl

#// Send a certain amount of tokens to an address
#// Ex value for parameters (do not actually use these values in your tx!!): <to_address>=cosmos16m93fezfiezhvnjajzrfyszml8qm92a0w67ntjhd3d0 <amount>=1000000uatom
#// Ex value for flags: <gasPrice>=0.0025uatom

gaiad query staking validator <validator cosmosvaloper address>
# is the returned public address from DVS Validator's cosmosvaloper address

gaiad tx bank send M1_key cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv 1000000uatom --fees=500uatom --note="afb3c11a841de7d7b238a03f072e2c1480e790ac@143.198.157.127:26656"


# my peer address: afb3c11a841de7d7b238a03f072e2c1480e790ac@143.198.157.127:26656

# txhash: 31EC711FF09667A464C03BB7F4102E6C3E4106F8A10DC0BEB31393C48AB2FA6B of transaction with memo, and sending of 1 atom to DVS validator


# Send 500uatom to addr_1 in the same transaction
gaiad tx bank send M1_key cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv 500uatom \
  --from=M1_key \
  --chain-id=school-testnet-1 \
  --fees=500uatom \
  --generate-only=true > unsignedTx1.json


  cyborg_addr = cosmos1z2ctljf4s4z0cl03p9maek5m3sm88jmds4vqr0

  # send 1000000uatom to cyborg_addr
gaiad tx bank send M1_key cosmos1z2ctljf4s4z0cl03p9maek5m3sm88jmds4vqr0 1000000uatom \
  --chain-id=school-testnet-1 \
  --fees=500uatom \
  --generate-only=true > unsignedTx2.json

  # send 500uatom to DVS validator
gaiad tx bank send cosmos1ps3f0jpwfh07hq7u7xxxerx5axcmd0hpjsj9g6 cosmos1z2ctljf4s4z0cl03p9maek5m3sm88jmds4vqr0 500uatom \
  --chain-id school-testnet-1 \
  --fees 500uatom \
  --generate-only=true > unsigned_Tx2.json \


gaiad tx bank send cosmos1ps3f0jpwfh07hq7u7xxxerx5axcmd0hpjsj9g6 cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv 500uatom \
  --chain-id school-testnet-1 \
  --fees 500uatom \
  --generate-only=true > unsigned_Tx1.json \
