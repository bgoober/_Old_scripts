#!/bin/bash


fetchd config chain-id dorado-1
fetchd config node https://rpc-dorado.fetch.ai:443



# init
fetchd init monarch-test-node --chain-id dorado-1


# genesis
curl https://rpc-dorado.fetch.ai:443 | jq '.result.genesis' > ~/.fetchd/config/genesis.json


# ...or, if that's too large to download from the rpc interface as a single file...
curl https://storage.googleapis.com/fetch-ai-testnet-genesis/genesis-dorado-827201.json --output ~/.fetchd/config/genesis.json


# start
fetchd start --p2p.seeds=eb9b9717975b49a57e62ea93aa4480e091ae0660@connect-dorado.fetch.ai:36556,46d2f86a255ece3daf244e2ca11d5be0f16cb633@connect-dorado.fetch.ai:36557,066fc564979b1f3173615f101b62448ac7e00eb1@connect-dorado.fetch.ai:36558

