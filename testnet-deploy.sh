#!/bin/bash

./build.sh

export PARENT_ACCT=renatomartin.testnet
export NEAR_ACCT=movitdapp.renatomartin.testnet
export NEAR_ACCT_B=bob.renatomartin.testnet


# delete NEAR_ACCT and send remaining funds to PARENT_ACCT
near delete $NEAR_ACCT $PARENT_ACCT
near delete $NEAR_ACCT_B $PARENT_ACCT


# create NEAR_ACCT as child of PARENT_ACCT
near create-account $NEAR_ACCT --initialBalance 5 --masterAccount $PARENT_ACCT
near create-account $NEAR_ACCT_B --initialBalance 5 --masterAccount $PARENT_ACCT

# deploy contract to NEAR_ACCT
near deploy $NEAR_ACCT --wasmFile res/movit.wasm --accountId $NEAR_ACCT


# Call some method
# near call $NEAR_ACCT get_solution '{}' --accountId $NEAR_ACCT
near call --accountId $NEAR_ACCT $NEAR_ACCT  new '{"owner_id": "'$NEAR_ACCT'" }'
near call --accountId $NEAR_ACCT $NEAR_ACCT  mint_token '{ "token_id":1234, "owner_id": "'$NEAR_ACCT'" }'
near view --accountId $NEAR_ACCT $NEAR_ACCT  get_token_meta '{"token_id":1234}'
near call --accountId $NEAR_ACCT $NEAR_ACCT show_token '{ "token_id":1234, "_owner_id": "'$NEAR_ACCT'" ,"_ability" : "Force"}'
near call --accountId $NEAR_ACCT $NEAR_ACCT update_token '{ "token_id":1234, "_owner_id": "'$NEAR_ACCT'" ,"ability" : "Force"}'
near view --accountId $NEAR_ACCT $NEAR_ACCT  get_token_meta '{"token_id":1234}'
near view --accountId $NEAR_ACCT $NEAR_ACCT  get_token_owner '{"token_id":1234}'
near call --accountId $NEAR_ACCT $NEAR_ACCT transfer_token '{ "token_id":1234, "_owner_id": "'$NEAR_ACCT'" ,"new_owner_id" : "'$NEAR_ACCT_B'"}'
near view --accountId $NEAR_ACCT $NEAR_ACCT  get_token_owner '{"token_id":1234}'
