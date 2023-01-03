#!/bin/bash

### Configuration ###

export KEY_NAME=M1_key
export GAS_PRICE=0.0025uatom
export DVS= # input DVS validator's cosmosvaloper address here
export VAL1= # input another random validator address here
export VAL2= # input a second random validator address here
export BOND=1000000uatom
export UNBOND=100000uatom
export REDELEGATE=100000uatom

### Configuration ###

#// Bond a certain amount of Atoms to a given validator
#// ex value for flags: <validatorAddress>=cosmosvaloper18thamkhnj9wz8pa4nhnp9rldprgant57pk2m8s, <amountToBound>=10000000uatom, $GAS_PRICE=0.0025uatom
gaiad tx staking delegate $DVS $BOND \
    --from $KEY_NAME \
    --gas auto \
    --gas-adjustment 1.5 \
    --gas-prices $GAS_PRICE

gaiad tx staking delegate $VAL1 $BOND \
    --from $KEY_NAME \
    --gas auto \
    --gas-adjustment 1.5 \
    --gas-prices $GAS_PRICE

#// Redelegate a certain amount of Atoms from a validator to another
#// Can only be used if already bonded to a validator
#// Redelegation takes effect immediately, there is no waiting period to redelegate
#// After a redelegation, no other redelegation can be made from the account for the next 3 weeks
#// ex value for flags: <stcValidatorAddress>=cosmosvaloper18thamkhnj9wz8pa4nhnp9rldprgant57pk2m8s, <amountToRedelegate>=100000000uatom, $GAS_PRICE=0.0025uatom
gaiad tx staking redelegate $VAL1 $DVS $REDELEGATE \
    --from $KEY_NAME \
    --gas auto \
    --gas-adjustment 1.5 \
    --gas-prices $GAS_PRICE

#// Unbond a certain amount of Atoms from a given validator
#// You will have to wait 3 weeks before your Atoms are fully unbonded and transferrable
#// ex value for flags: <validatorAddress>=cosmosvaloper18thamkhnj9wz8pa4nhnp9rldprgant57pk2m8s, <amountToUnbound>=10000000uatom, $GAS_PRICE=0.0025uatom
gaiad tx staking unbond $DVS $UNBOND \
--from $KEY_NAME \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices $GAS_PRICE


#// Withdraw all rewards
#// ex value for flag: $GAS_PRICE=0.0025uatom
gaiad tx distribution withdraw-all-rewards \
--from $KEY_NAME \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices $GAS_PRICE






gaiad tx staking delegate cosmosvaloper1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umptp7zl 10000000uatom \
  --from=M1_key \
  --chain-id=school-testnet-1 \
  --gas=auto



gaiad query staking validator cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv


export DVS_Del = cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv
export DVS_Val = cosmosvaloper1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umptp7zl

export nodeist_val = cosmosvaloper1p09slwmzeacxeddqjrux4u027fhfdk5qlskahl

txhash: 8E7DE2D0B26D03A7210AC8DA007C96E0167BCEF908D26CB094D429027735D2B6
delegated 500uatom to DVS validator

# delegate 500uatom to nodeist validator
gaiad tx staking delegate cosmosvaloper1p09slwmzeacxeddqjrux4u027fhfdk5qlskahl 500uatom \
  --from=M1_key \
  --chain-id=school-testnet-1 \
  --fees=500uatom \

# D70BBBAAE94AF534C5C2A966510BA76066A7D0E714C0867E5BE7D741B91640BF Tx hash for delegating to nodeist validator  


gaiad tx staking delegate cosmosvaloper1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umptp7zl 1000000uatom \
  --from=M1_key \
  --chain-id=school-testnet-1 \
  --fees=500uatom \
  --note=https://twitter.com/B_M1Validator/status/1580258176364007424


 # hash for above tx : A7EB1628A8153DAF30F5B707EDCCF2A670946CEF16E4635E86F24AA8CA139E0A 


gaiad tx staking redelegate \
  <src-validator-operator-addr> \
  <dst-validator-operator-addr> \
  10atom \
  --from=<key_name> \
  --chain-id=<chain_id>



  # Redelegate 500uatom from nodeist validator to DVS validator
gaiad tx staking redelegate \
    cosmosvaloper1p09slwmzeacxeddqjrux4u027fhfdk5qlskahl \
    cosmosvaloper1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umptp7zl \
    500uatom \
    --from=M1_key \
    --chain-id=school-testnet-1 \

# txhash: 23EE3246DEFC43F42BF86E08C7EA31EF4C247CADD352689A7BB0C7093987FBE7 for redelegating 500uatom from nodeist to DVS validator

6AAD9DABF6AB4B1AE822DF5574C91AD0F6BF89BEFEC355740A081CDBE0FE2179



export address_1 = cosmos14xztlq73r6425c5vhu99ht46pkvzxq4yyrhx8t

export address_2 = cosmos1kymg8jgly66q2ry9nmjdw5kkc0l4dkf5rcs8z8


# send 500uatom to address_1 and 500uatom to address_2 in the same transaction
gaiad tx bank send M1_key \
  cosmos1kymg8jgly66q2ry9nmjdw5kkc0l4dkf5rcs8z8 \
  cosmos14xztlq73r6425c5vhu99ht46pkvzxq4yyrhx8t \
  500uatom \
  --chain-id=school-testnet-1 \
  --fees=500uatom \



