use dep::std;

fn main(
    root: pub Field, // @dev - Merkle Root
    index: Field,
    hash_path: [Field; 2],
    secret: Field,
    employeeId: Field,  // @dev - Employee ID (= Customer ID)
    income: u64         // @dev - Income of the employee (= Customer)
) -> pub Field {
    let note_commitment = std::hash::pedersen_hash([secret]);
    let nullifier = std::hash::pedersen_hash([root, secret, employeeId]);

    // Constraint: root == check_root
    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);

    // Constraint: income >= 4500
    assert(income >= 4500, "Annual Income of customer should be greater than 450 USD / year");

    nullifier // @dev - Return the nullifier -> Then, it will be stored on-chain so that it can be used to prevent double-spending.
}