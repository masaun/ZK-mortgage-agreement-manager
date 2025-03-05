echo "Compiling circuit..."
nargo compile
if [ $? -ne 0 ]; then
  exit 1
fi

echo "Generate witness..."
nargo execute

echo "Proving and generating a ZK Proof..."
bb prove -b ./target/employment_verification_letter.json -w ./target/employment_verification_letter.gz -o ./target/employment_verification_letter_proof.bin

echo "Generating vkey..."
bb write_vk -b ./target/employment_verification_letter.json -o ./target/employment_verification_letter_vk.bin

echo "Link vkey to the zkProof"
bb verify -k ./target/employment_verification_letter_vk.bin -p ./target/employment_verification_letter_proof.bin

echo "Check a zkProof"
head -c 32 ./target/employment_verification_letter_proof.bin | od -An -v -t x1 | tr -d $' \n'

echo "Copy and paste vk for generating a Solidity Verifier contract"
cp ./target/employment_verification_letter_vk.bin ./target/vk

echo "Generate a Solidity Verifier contract"
bb contract

echo "Done"