echo "Copy the .circuits/circuit-for-employer/Nargo.toml to the root directory of the circuits (./circuits) for the test of the EmploymentVerificationLetterProofVerifierTest..."
cp ./circuits/circuit-for-employer/Nargo.toml circuits/Nargo.toml

echo "Running the test of the EmploymentVerificationLetterProofVerifierTest..."
forge test --optimize --optimizer-runs 5000 --evm-version cancun --match-contract EmploymentVerificationLetterProofVerifierTest -vvv

echo "Remove the .circuits/circuit-for-employer/Nargo.toml froom the root diircuits/Nargo.tomlrectory of the circuits (./circuits)..."
rm ./circuits/Nargo.toml