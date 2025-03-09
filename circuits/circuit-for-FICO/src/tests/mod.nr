mod test_inputs; // test_inputs.nr

mod tests {
    use crate::main; // src/main.nr
    use crate::data_types::FICOCreditScoreInfo; // @dev - FICOCreditScoreInfo struct

    #[test]
    fn test_fico_credit_score_verifier() {
        let root: Field = 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629;   // @dev - Merkle Root
        let hash_path: [Field; 2] = [0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8, 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77];
        let index: Field = 0;
        let secret: Field = 1;
        let credit_score: u64 = 800;

        let ficoCreditScoreInfo: FICOCreditScoreInfo = FICOCreditScoreInfo {
            customer_name: 0x4a6f686e20536d697468,       // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
            customer_address: 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629,        // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
            customer_phone_number: 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629,   // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
            credit_score_in_struct: 800,    // @dev - Annual salary of the employee (in USD)
            credit_score_created_date: 1741365256
        };

        let nullifier = main(
            root,
            hash_path,
            index,
            secret,
            credit_score,
            ficoCreditScoreInfo,
        );

        let note_commitment = std::hash::pedersen_hash([secret]);
        let _nullifier = std::hash::pedersen_hash([root, secret, ficoCreditScoreInfo.customer_name]);

        // Constraint check
        assert(nullifier == _nullifier, "Invalid nullifier");

        println(nullifier);
        println("The test of the test_mortgage_loan_assessment_verifier()) has been successful");
    }
}