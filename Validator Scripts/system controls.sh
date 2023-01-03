#!/bin/bash -i

# Resets the tendermint app state/database so you can resync from an empty chain state
gaiad tendermint unsafe-reset-all --home ~/.gaia

# sha checksum against curl’d file contents
sha256sum ~/.gaia/config/genesis.json

# check the iptables that ufw is allowing
sudo iptables --list

# reload daemon, enable gaiad on startup
sudo systemctl daemon-reload
sudo systemctl enable gaiad

# stop gaiad only if needed
sudo systemctl stop gaiad

# live journal of gaiad activities and flow
journatlctl -fu gaiad

# check the contents of the gaiad service in your etc/systemd/system directory
sudo cat /etc/systemd/system/gaiad.service



# Allow ports on ufw before enabling, or you will lose ssh ability and this will suck

sudo ufw allow 22

sudo ufw allow 26656 
# or whichever port your own public IP is listening on

sudo ufw enable

sudo ufw status