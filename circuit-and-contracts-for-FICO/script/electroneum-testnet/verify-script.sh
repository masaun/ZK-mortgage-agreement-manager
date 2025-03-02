echo "Load the environment variables from the .env file..."
. ./.env

echo "Verifying a proof via the Starter (UltraVerifier) contract on Sonic Blaze Testnet..."
forge script script/electroneum-testnet/Verify.s.sol --broadcast --private-key ${SONIC_BLAZE_TESTNET_PRIVATE_KEY} --skip-simulation