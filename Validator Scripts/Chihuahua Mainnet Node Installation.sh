 NODE_MONIKER="Monarch" 


# install dependencies, if needed
sudo apt update
sudo apt install -y curl git jq lz4 build-essential

if [ ! -f "/usr/local/go/bin/go" ]; then
  bash <(curl -s "https://raw.githubusercontent.com/BadgerbiteInfo/scripts/main/utils/go_install.sh")
  source .bash_profile
fi



#!/bin/bash

#Cloning Repo and Building Binary
cd || return
rm -rf chihuahua
git clone https://github.com/chihuahuachain/chihuahua.git
cd chihuahua || return
git fetch --tags
git checkout v2.0.2
make install
chihuahuad version

# initialising Binary and Adjusting Fess and Peers
chihuahuad init $NODE_MONIKER --chain-id chihuahua-1
curl https://raw.githubusercontent.com/ChihuahuaChain/chihuahua/main/mainnet/genesis.json > ~/.chihuahua/config/genesis.json

perl -i -pe 's/^minimum-gas-prices = .+?$/minimum-gas-prices = "0.0125uhuahua"/' ~/.chihuahua/config/app.toml

SEEDS="4936e377b4d4f17048f8961838a5035a4d21240c@chihuahua-seed-01.mercury-nodes.net:29540"
PEERS="b140eb36b20f3d201936c4757d5a1dcbf03a42f1@216.238.79.138:26656,19900e1d2b10be9c6672dae7abd1827c8e1aad1e@161.97.96.253:26656,c382a9a0d4c0606d785d2c7c2673a0825f7c53b2@88.99.94.120:26656,a5dfb048e4ed5c3b7d246aea317ab302426b37a1@137.184.250.180:26656,3bad0326026ca4e29c64c8d206c90a968f38edbe@128.199.165.78:26656,89b576c3eb72a4f0c66dc0899bec7c21552ea2a5@23.88.7.73:29538,38547b7b6868f93af1664d9ab0e718949b8853ec@54.184.20.240:30758,a9640eb569620d1f7be018a9e1919b0357a18b8c@38.146.3.160:26656,7e2239a0d4a0176fe4daf7a3fecd15ac663a8eb6@144.91.126.23:26656"
sed -i -e 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' ~/.chihuahua/config/config.toml
 
# in case of pruning
sed -i 's|pruning = "default"|pruning = "custom"|g' ~/.chihuahua/config/app.toml
sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|g' ~/.chihuahua/config/app.toml
sed -i 's|pruning-interval = "0"|pruning-interval = "10"|g' ~/.chihuahua/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' ~/.chihuahua/config/app.toml
 
#Setting Up Service
sudo tee /etc/systemd/system/chihuahuad.service > /dev/null << EOF
[Unit]
Description=chihuahua-1 Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which chihuahuad) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
 
# Setting Up Statesync
chihuahuad tendermint unsafe-reset-all --home ~/.chihuahua/ --keep-addr-book
 
SNAP_RPC="https://rpc.cosmos.directory/chihuahua/"
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

# Displaying Height and hash
echo "TRUST HEIGHT: $BLOCK_HEIGHT"
echo "TRUST HASH: $TRUST_HASH"

# editing config.toml with correct values
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; ~/.chihuahua/config/config.toml
 
# Enabling and Restarting Service
sudo systemctl daemon-reload
sudo systemctl enable chihuahuad
sudo systemctl restart chihuahuad

sudo journalctl -u chihuahuad -f --no-hostname -o cat
