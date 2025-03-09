mod data_types {

    use crate::main; // src/main.nr
    
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

}