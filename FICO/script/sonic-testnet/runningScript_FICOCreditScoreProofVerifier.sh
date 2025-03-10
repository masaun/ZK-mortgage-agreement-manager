echo "Load the environment variables from the .env file..."
. ./.env

echo "Verifying a proof via the FICOCreditScoreProofVerifier (UltraVerifier) contract on Sonic Blaze Testnet..."
forge script script/FICO/sonic-testnet/FICOCreditScoreProofVerifier.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} --skip-simulation