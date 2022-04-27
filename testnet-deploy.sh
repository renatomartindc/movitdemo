#!/bin/bash

./build.sh

export PARENT_ACCT=renatomartin.testnet
export NEAR_ACCT=movitdapp.renatomartin.testnet


# delete NEAR_ACCT and send remaining funds to PARENT_ACCT
near delete $NEAR_ACCT $PARENT_ACCT

# create NEAR_ACCT as child of PARENT_ACCT
near create-account $NEAR_ACCT --initialBalance 5 --masterAccount $PARENT_ACCT


# deploy contract to NEAR_ACCT
near deploy $NEAR_ACCT --wasmFile res/non_fungible_token.wasm --accountId $NEAR_ACCT


# Call some method
# near call $NEAR_ACCT get_solution '{}' --accountId $NEAR_ACCT
