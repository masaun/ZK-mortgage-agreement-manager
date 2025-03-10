use dep::std;
mod tests;       // tests/mod.nr
mod data_types;  // data_types.nr

use data_types::FICOCreditScoreInfo; // @dev - FICOCreditScoreInfo struct

/**
 * @notice - This is the ZK circuit for verifying the income of the employee (= customer, borrower)
 */
fn main(
    root: pub Field, // @dev - Merkle Root
    hash_path: [Field; 2],
    index: Field,
    secret: Field,             // @dev - a one time secret code that was distributed to each customer (before the proof generation get started)
    credit_score: pub u64,     // @dev - The FICO credit score is typically updated every 30-45 days.
    ficoCreditScoreInfo: FICOCreditScoreInfo    
) -> pub Field {
    let note_commitment = std::hash::pedersen_hash([secret]);
    let nullifier = std::hash::pedersen_hash([root, secret, ficoCreditScoreInfo.customer_name]);

    // Constraint: root == check_root
    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);

    // Constraint: 
    assert(credit_score == ficoCreditScoreInfo.credit_score_in_struct, "Invalid credit score");

    nullifier // @dev - Return the nullifier -> Then, it will be stored on-chain so that it can be used to prevent double-spending.
}