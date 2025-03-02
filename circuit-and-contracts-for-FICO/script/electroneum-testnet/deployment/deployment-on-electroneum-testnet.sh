echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and Starter contract on Sonic Blaze Testnet..."
forge script script/electroneum-testnet/deployment/DeploymentAllContracts.s.sol --broadcast --private-key ${ELECTRONEUM_TESTNET_PRIVATE_KEY} \
    ./circuits/target/contract.sol:UltraVerifier \
    ./Starter.sol:Starter --skip-simulation --legacy

# [NOTE - Adding the "--legacy" option]: Due to this error - Error: Failed to estimate EIP1559 fees. This chain might not support EIP1559, try adding --legacy to your command.