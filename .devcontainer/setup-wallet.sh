#!/bin/bash

# restart keosd for setting unlock timeout 
cleos wallet stop

# remove any previous wallets
rm -fr ~/eosio-wallet ~/wallet.pwd 

# start again with loong unlock setting
keosd --wallet-dir ~/eosio-wallet \
--logconf=/root/wallet-logging-confing.json \
--http-validate-host=false \
--http-server-address=0.0.0.0:8889 \
--unlock-timeout 315360000 &                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

# create default wallet
cleos wallet create -f ~/wallet.pwd

# Check if .env file containing lines of the form`account=PK` is provided as an argument
if [ $# -eq 0 ]; then
  echo "Warning: .env file with account keys was not provided as an argument. Will not import any keys into wallet"
  exit 0
fi

# Check if the provided argument indeed points to existing file
if [ ! -f "$1" ]; then 
  echo "Warning: The provided file '$1' does not exist. Will not import any keys into wallet"
  exit 0 
fi

# Read the accounts.env file
# Actual accounts.env is passed with full path from .devcontainer.json, postStartCommand
while IFS='=' read -r key value; do
  # Skip empty lines and comments
  if [[ -n "$key" && "${key:0:1}" != "#" ]]; then
    # import eos account key into wallet
    cleos wallet import --private-key $value
  fi
done < "$1"