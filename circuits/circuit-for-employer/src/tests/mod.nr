mod test_inputs; // test_inputs.nr
mod data_types;  // data_types.nr

mod tests {
    use crate::main; // src/main.nr
    use crate::tests::data_types::DataTypes::EmployeeVerificationLetterInfo;
    // use crate::main::EmployeeVerificationLetterInfo;
    // use crate::MAX_DATA_LENGTH;
    // use crate::tests::test_inputs::TestCase1::{
    //     SIGNED_DATA, NULLIFIER_SEED, SIGNED_DATA_LENGTH, DELIMITER, SIGNATURE_LIMBS, MODULUS_LIMBS,
    //     REDC_LIMBS, SIGNAL_HASH,
    // };

    // struct EmployeeVerificationLetterInfo {
    //     employee_name: Field,          // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    //     employee_address: Field,       // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    //     employee_phone_number: Field,  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    //     title: Field,                  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    //     contract_type: Field,          // @dev - "Full Time" or "Part Time"
    //     annual_salary_in_struct: u64,  // @dev - Annual salary of the employee (in USD)
    //     employment_start_date: u64,    // @dev - "Field" is equal to "i254" (integer 254)
    //     employment_end_date: u64,
    //     letter_created_date: u64
    // }

    #[test]
    fn test_employee_verification_letter_verifier() {
        let root: Field = 0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629;   // @dev - Merkle Root
        let hash_path: [Field; 2] = [0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8, 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77];
        let index: Field = 0;
        let secret: Field = 1;
        let annual_salary: u64 = 800;

        let employeeVerificationLetterInfo: EmployeeVerificationLetterInfo = EmployeeVerificationLetterInfo {
            employee_name: 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77,
            employee_address: 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8,
            employee_phone_number: 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77,
            title: 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8,
            contract_type: 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77,
            annual_salary_in_struct: 800,
            employment_start_date: 55000,
            employment_end_date: 55000,
            letter_created_date: 55000
        };

        let nullifier = main(
            root,
            hash_path,
            index,
            secret,
            annual_salary,
            employeeVerificationLetterInfo
        );

        let note_commitment = std::hash::pedersen_hash([secret]);
        let _nullifier = std::hash::pedersen_hash([root, secret, employeeVerificationLetterInfo.contract_type]);

        // Constraint check
        assert(nullifier == _nullifier, "Invalid nullifier");

        println(nullifier);
        println("The test of the employee_verification_letter_verifier() has been successful");
    }
}