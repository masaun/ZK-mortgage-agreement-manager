echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and Starter contract on Sonic Blaze Testnet..."
forge script script/DeploymentAllContracts.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} \
    ./circuits/target/contract.sol:UltraVerifier \
    ./Starter.sol:Starter --skip-simulation