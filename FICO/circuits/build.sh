echo "Compiling circuit..."
nargo compile
if [ $? -ne 0 ]; then
  exit 1
fi

echo "Generate witness..."
nargo execute

echo "Proving and generating a ZK Proof..."
bb prove -b ./target/fico_credit_score.json -w ./target/fico_credit_score.gz -o ./target/fico_credit_score_proof.bin

echo "Generating vkey..."
bb write_vk -b ./target/fico_credit_score.json -o ./target/fico_credit_score_vk.bin

echo "Link vkey to the zkProof"
bb verify -k ./target/fico_credit_score_vk.bin -p ./target/fico_credit_score_proof.bin

echo "Check a zkProof"
head -c 32 ./target/fico_credit_score_proof.bin | od -An -v -t x1 | tr -d $' \n'

echo "Copy and paste vk for generating a Solidity Verifier contract"
cp ./target/fico_credit_score_vk.bin ./target/vk

echo "Generate a Solidity Verifier contract"
bb contract

echo "Copy a Solidity Verifier contract-generated into the ./contracts/FICO/circuit directory"
cp ./target/contract.sol ../contracts/circuit

echo "Rename the contract.sol with the plonk_vk.sol in the ./contracts/FICO/circuit directory"
mv ../contracts/circuit/contract.sol ../contracts/circuit/plonk_vk.sol

echo "Done"