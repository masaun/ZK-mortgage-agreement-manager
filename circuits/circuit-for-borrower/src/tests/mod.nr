mod test_inputs; // test_inputs.nr

mod tests {
    use crate::main;        // src/main.nr
    use crate::data_types::MortgageLoanAssessmentData;  // src/data_types.nr

    #[test]
    fn test_mortgage_loan_assessment_verifier() {
        let root: Field = 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629;   // @dev - Merkle Root
        let hash_path: [Field; 2] = [0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8, 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77];
        let index: Field = 0;
        let secret: Field = 1;

        let mortgageLoanAssessmentData: MortgageLoanAssessmentData = MortgageLoanAssessmentData {
            fico_credit_score_proof: 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77,
            fico_credit_score_proof_hash: 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8,
            employment_verification_letter_proof: 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77,
            employment_verification_letter_proof_hash: 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8,
            credit_score: 800,
            income: 55000
        };

        let nullifier = main(
            root,
            hash_path,
            index,
            secret,
            mortgageLoanAssessmentData,
        );

        let note_commitment = std::hash::pedersen_hash([secret]);
        let _nullifier = std::hash::pedersen_hash([root, secret, mortgageLoanAssessmentData.fico_credit_score_proof_hash, mortgageLoanAssessmentData.employment_verification_letter_proof_hash]);

        // Constraint check
        assert(nullifier == _nullifier, "Invalid nullifier");

        println(nullifier);
        println("The test of the test_mortgage_loan_assessment_verifier()) has been successful");
    }
}