echo "Load the environment variables from the .env file..."
source .env
#. ./.env

# Set the RPC URL for the Sonic Testnet
#export SONIC_BLAZE_TESTNET_RPC="https://rpc.ankr.com/electroneum_testnet"

echo "Running the test of the MortgageAgreementManagerTest on Sonic Testnet..."
forge test --optimize --optimizer-runs 5000 --evm-version cancun --match-contract MortgageAgreementManagerTest -vv --rpc-url ${SONIC_BLAZE_TESTNET_RPC}