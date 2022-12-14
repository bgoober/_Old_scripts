#!/bin/bash


Cleaned

# compile wasm - run this in your smart contract folder

sudo docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/rust-optimizer:0.12.8


# copy wasm to container

sudo docker cp artifacts/pet_that_dog.wasm juno_node_1:/pet_that_dog.wasm

# store wasm on-chain

sudo docker exec -i juno_node_1 \
  junod tx wasm store "/pet-that-dog" \
  --gas-prices 0.1ujunox --gas auto --gas-adjustment 1.3 \
  -y -b block --chain-id testing \
  --from validator --output json
  
  
  
  
  RAW
  
  # compile wasm - run this in your smart contract folder
docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/rust-optimizer:0.12.8

# copy wasm to container
docker cp artifacts/your_compiled.wasm juno_node_1:/your_compiled.wasm

# store wasm
docker exec -i juno_node_1 \
  junod tx wasm store "/your_compiled.wasm" \
  --gas-prices 0.1ujunox --gas auto --gas-adjustment 1.3 \
  -y -b block --chain-id testing \
  --from validator --output json 
