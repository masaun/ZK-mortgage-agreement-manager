echo "Compiling circuit..."
nargo compile
if [ $? -ne 0 ]; then
  exit 1
fi

echo "Generate witness..."
nargo execute

echo "Proving and generating a ZK Proof..."
bb prove -b ./target/mortgage_affordability.json -w ./target/mortgage_affordability.gz -o ./target/mortgage_affordability_proof.bin

echo "Generating vkey..."
bb write_vk -b ./target/mortgage_affordability.json -o ./target/mortgage_affordability_vk.bin

echo "Link vkey to the zkProof"
bb verify -k ./target/mortgage_affordability_vk.bin -p ./target/mortgage_affordability_proof.bin

echo "Check a zkProof"
head -c 32 ./target/mortgage_affordability_proof.bin | od -An -v -t x1 | tr -d $' \n'

echo "Copy and paste vk for generating a Solidity Verifier contract"
cp ./target/mortgage_affordability_vk.bin ./target/vk

echo "Generate a Solidity Verifier contract"
bb contract

echo "Copy a Solidity Verifier contract-generated into the ./contracts/borrower/circuit directory"
cp ./target/contract.sol ../contracts/circuit

echo "Rename the contract.sol with the plonk_vk.sol in the ./contracts/borrower/circuit directory"
mv ../contracts/circuit/contract.sol ../contracts/circuit/plonk_vk.sol

echo "Done"