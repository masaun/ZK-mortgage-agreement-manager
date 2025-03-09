echo "Load the environment variables from the .env file..."
. ./.env

echo "Running the EmploymentVerificationLetterProofVerifier (UltraVerifier) script on Sonic Blaze Testnet..."
forge script script/employer/sonic-testnet/EmploymentVerificationLetterProofVerifier.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} --skip-simulation --rpc-url $SONIC_BLAZE_TESTNET_RPC