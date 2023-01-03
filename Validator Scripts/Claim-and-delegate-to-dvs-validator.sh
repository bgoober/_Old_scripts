#!/bin/bash

### Configuration ###

export KEY_NAME=M1_key
export GAS_PRICE=0.0025uatom
export DVS= # input DVS validator's cosmosvaloper address here
export BOND=1000000uatom
export REDELEGATE=100000uatom

### Configuration ###



#// Withdraw all rewards
#// ex value for flag: $GAS_PRICE=0.0025uatom
gaiad tx distribution withdraw-all-rewards \
--from $KEY_NAME \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices $GAS_PRICE


#// Bond a certain amount of Atoms to a given validator
#// ex value for flags: <validatorAddress>=cosmosvaloper18thamkhnj9wz8pa4nhnp9rldprgant57pk2m8s, <amountToBound>=10000000uatom, $GAS_PRICE=0.0025uatom
gaiad tx staking delegate $DVS $BOND \
    --from $KEY_NAME \
    --gas auto \
    --gas-adjustment 1.5 \
    --gas-prices $GAS_PRICE