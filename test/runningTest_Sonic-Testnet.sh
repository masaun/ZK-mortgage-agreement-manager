echo "Load the environment variables from the .env file..."
source .env
#. ./.env

# Set the RPC URL for the Sonic Blaze Testnet
#export SONIC_BLAZE_TESTNET_RPC="https://rpc.blaze.soniclabs.com"

echo "Running the test of the StarterOnSonicTestnet on Sonic Testnet..."
forge test --optimize --optimizer-runs 5000 --evm-version cancun --match-contract StarterOnSonicTestnetTest -vv --rpc-url ${SONIC_BLAZE_TESTNET_RPC}
