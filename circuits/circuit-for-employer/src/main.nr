use dep::std;
mod tests; // tests/mod.nr

/**
 * @notice - This is the ZK circuit for proving/verifying a proof of "Employment (Income) Verification Letter".
 */
fn main(
    root: pub Field, // @dev - Merkle Root
    index: Field,
    hash_path: [Field; 2],
    secret: Field,   // @dev - a secret code that was distributed to each voter (before the voting starts)
    employee_name: str,
    employee_address: str,
    employee_phone_number: str,
    title: str,
    contract_type: str,  // @dev - "Full Time" or "Part Time"
    annual_salary: pub u64, // @dev - Annual salary of the employee (in USD)
    employment_start_date: u64,
    employment_end_date: u64,
    letter_created_date: u64
) -> pub Field {
    let note_commitment = std::hash::pedersen_hash([secret]);
    let nullifier = std::hash::pedersen_hash([root, secret, fico_credit_score_proof_hash, employment_verification_letter_proof_hash]);

    // Constraint: root == check_root
    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);

    // Constraint: income >= 50000 (in USD / year)
    //assert(income >= 50000, "Annual Income of customer should be greater than 50000 USD / year");

    nullifier // @dev - Return the nullifier -> Then, it will be stored on-chain so that it can be used to prevent double-spending.
}