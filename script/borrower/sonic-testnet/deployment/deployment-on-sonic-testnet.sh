echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and MortgageAffordabilityProofVerifier contract on Sonic Blaze Testnet..."
forge script script/sonic-testnet/deployment/DeploymentAllContracts.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} \
    ./circuits/target/contract.sol:UltraVerifier \
    ./MortgageAffordabilityProofVerifier.sol:MortgageAffordabilityProofVerifier --skip-simulation