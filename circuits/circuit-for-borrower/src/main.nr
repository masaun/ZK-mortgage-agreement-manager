use dep::std;
mod tests;      // tests/mod.nr
mod data_types; // data_types.nr

use data_types::MortgageLoanAssessmentData; // @dev - MortgageLoanAssessmentData struct

/**
 * @notice - This is the ZK circuit for verifying the income of the employee (= customer, borrower)
 */
fn main(
    root: pub Field, // @dev - Merkle Root
    hash_path: [Field; 2],
    index: Field,
    secret: Field,   // @dev - a one time secret code that was distributed to each customer (before the proof generation get started)
    mortgageLoanAssessmentData: MortgageLoanAssessmentData
) -> pub Field {
    let note_commitment = std::hash::pedersen_hash([secret]);
    let nullifier = std::hash::pedersen_hash([root, secret, mortgageLoanAssessmentData.fico_credit_score_proof_hash, mortgageLoanAssessmentData.employment_verification_letter_proof_hash]);

    // Constraint: root == check_root
    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);

    // Constraint: Check whether or not both given proofs are valid.
    //assert(std::hash::pedersen_hash([fico_credit_score_proof]) == fico_credit_score_proof_hash);
    //assert(std::hash::pedersen_hash([employment_verification_letter_proof]) == employment_verification_letter_proof_hash);

    // Constraint: credit_score >= 700
    assert(mortgageLoanAssessmentData.credit_score >= 700, "Credit score of customer should be greater than 700");

    // Constraint: income >= 50000 (in USD / year)
    assert(mortgageLoanAssessmentData.income >= 50000, "Annual Income of customer should be greater than 50000 USD / year");

    nullifier // @dev - Return the nullifier -> Then, it will be stored on-chain so that it can be used to prevent double-spending.
}