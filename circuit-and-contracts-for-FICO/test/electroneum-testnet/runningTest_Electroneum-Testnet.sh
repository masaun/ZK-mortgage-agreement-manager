echo "Load the environment variables from the .env file..."
source .env
#. ./.env

# Set the RPC URL for the Electroneum Testnet
#export ELECTRONEUM_TESTNET_RPC="https://rpc.ankr.com/electroneum_testnet"

echo "Running the test of the StarterOnElectroneumTestnet on Electroneum Testnet..."
forge test --optimize --optimizer-runs 5000 --evm-version cancun --match-contract StarterOnElectroneumTestnetTest -vv --rpc-url ${ELECTRONEUM_TESTNET_RPC}
