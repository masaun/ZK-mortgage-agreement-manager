use dep::std;
mod tests; // tests/mod.nr

struct EmployeeVerificationLetterInfo {
    employee_name: Field,          // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    employee_address: Field,       // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    employee_phone_number: Field,  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    title: Field,                  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    contract_type: Field,          // @dev - "Full Time" or "Part Time"
    annual_salary_in_struct: u64,  // @dev - Annual salary of the employee (in USD)
    employment_start_date: u64,    // @dev - "Field" is equal to "i254" (integer 254)
    employment_end_date: u64,
    letter_created_date: u64
}

/**
 * @notice - This is the ZK circuit for proving/verifying a proof of "Employment (Income) Verification Letter".
 */
fn main(
    root: pub Field, // @dev - Merkle Root
    index: Field,
    hash_path: [Field; 2],
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