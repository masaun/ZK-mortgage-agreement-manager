echo "Load the environment variables from the .env file..."
. ./.env

echo "Verifying a proof via the MortgageAffordabilityProofVerifier (UltraVerifier) contract on Sonic Blaze Testnet..."
forge script script/sonic-testnet/MortgageAffordabilityProofVerifier.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} --skip-simulation