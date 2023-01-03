gaiad tx bank send cosmos1ps3f0jpwfh07hq7u7xxxerx5axcmd0hpjsj9g6 cosmos1z2ctljf4s4z0cl03p9maek5m3sm88jmds4vqr0 500uatom \
  --chain-id school-testnet-1 \
  --fees 500uatom \
  --generate-only=true > unsigned_Tx2.json \


gaiad tx bank send cosmos1ps3f0jpwfh07hq7u7xxxerx5axcmd0hpjsj9g6 cosmos1ndmxkmwh9cnzcj6qpcs0r20pvw04q0umyl4twv 500uatom \
  --chain-id school-testnet-1 \
  --fees 500uatom \
  --generate-only=true > unsigned_Tx1.json \


gaiad tx sign unsigned_tx.json --chain-id=school-testnet-1 --from M1_key 



# sign the unsigned transaction with the private key of the sender
gaiad tx sign unsigned_tx.json --chain-id=school-testnet-1 --from M1_key > signed_tx.json

# broadcast the signed transaction
gaiad tx broadcast unsigned_tx.json --gas=auto -y --gas-adjustment=1.5 --fees=900uatom
