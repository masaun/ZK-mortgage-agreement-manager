echo "Load the environment variables from the .env file..."
. ./.env

echo "Running the FICOCreditScoreProofVerifier (UltraVerifier) script on Sonic Blaze Testnet..."
forge script script/FICO/sonic-testnet/FICOCreditScoreProofVerifier.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} --skip-simulation --rpc-url $SONIC_BLAZE_TESTNET_RPC