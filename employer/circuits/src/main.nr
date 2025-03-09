use dep::std;
mod tests; // tests/mod.nr
mod data_types; // data_types.nr

use data_types::EmployeeVerificationLetterInfo; // @dev - EmployeeVerificationLetterInfo struct

/**
 * @notice - This is the ZK circuit for proving/verifying a proof of "Employment (Income) Verification Letter".
 */
pub fn main(
    root: pub Field, // @dev - Merkle Root
    hash_path: [Field; 2],
    index: Field,
    secret: Field,          // @dev - a secret code that was distributed to each voter (before the voting starts)
    annual_salary: pub u64, // @dev - Annual salary of the employee (in USD)
    employeeVerificationLetterInfo: EmployeeVerificationLetterInfo
) -> pub Field {
    let note_commitment = std::hash::pedersen_hash([secret]);
    let nullifier = std::hash::pedersen_hash([root, secret, employeeVerificationLetterInfo.contract_type]);

    // Constraint: root == check_root
    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);

    // Constraint: 
    assert(annual_salary == employeeVerificationLetterInfo.annual_salary_in_struct, "Invalid annual salary");
    assert(employeeVerificationLetterInfo.employment_end_date > employeeVerificationLetterInfo.employment_start_date, "Invalid employment period");

    nullifier // @dev - Return the nullifier -> Then, it will be stored on-chain so that it can be used to prevent double-spending.
}