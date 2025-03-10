echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and MortgageAffordabilityProofVerifier contract on Sonic Blaze Testnet..."
forge script script/sonic-testnet/deployment/DeployMortgageAffordabilityProofVerifier.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} \
    ./contracts/circuit/plonk_vk.sol:UltraVerifier \
    ./MortgageAffordabilityProofVerifier.sol:MortgageAffordabilityProofVerifier \
    --skip-simulation