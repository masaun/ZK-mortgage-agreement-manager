echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying the UltraVerifier and FICOCreditScoreProofVerifier contract on Sonic Blaze Testnet..."
forge script script/sonic-testnet/deployment/DeploymentAllContracts.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} \
    ./contracts/circuit/plonk_vk.sol:UltraVerifier \
    ./FICOCreditScoreProofVerifier.sol:FICOCreditScoreProofVerifier \
    --skip-simulation