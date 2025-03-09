pub struct EmployeeVerificationLetterInfo {
    pub employee_name: Field,          // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    pub employee_address: Field,       // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    pub employee_phone_number: Field,  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    pub title: Field,                  // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    pub contract_type: Field,          // @dev - "Full Time" or "Part Time"
    pub annual_salary_in_struct: u64,  // @dev - Annual salary of the employee (in USD)
    pub employment_start_date: u64,    // @dev - "Field" is equal to "i254" (integer 254)
    pub employment_end_date: u64,
    pub letter_created_date: u64
}
