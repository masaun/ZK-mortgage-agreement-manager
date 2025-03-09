pub struct FICOCreditScoreInfo {
    customer_name: Field,           // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    customer_address: Field,        // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    customer_phone_number: Field,   // bytes (Sould be converted from String to bytes via abi.encodePacked() - before inputing here)
    credit_score_in_struct: u64,    // @dev - Annual salary of the employee (in USD)
    credit_score_created_date: u64
}