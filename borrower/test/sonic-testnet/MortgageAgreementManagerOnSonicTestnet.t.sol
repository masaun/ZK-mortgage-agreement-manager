pragma solidity ^0.8.17;

import { EmploymentVerificationLetterProofVerifier } from "../../employer/contracts/EmploymentVerificationLetterProofVerifier.sol";
import { FICOCreditScoreProofVerifier } from "../../FICO/contracts/FICOCreditScoreProofVerifier.sol";
import { MortgageAffordabilityProofVerifier } from "../contracts/MortgageAffordabilityProofVerifier.sol";

import { DataTypes } from "../contracts/libraries/DataTypes.sol";

import { NoirHelper } from "foundry-noir-helper/NoirHelper.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract MortgageAffordabilityProofVerifierTest is Test {
    NoirHelper public noirHelper;

    EmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    FICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;

    /// [TODO]: Read the each deployed address from the configuration file.
    address DEPLOYED_ADDRESS_OF_EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = 0x1234567890123456789012345678901234567890;
    address DEPLOYED_ADDRESS_OF_FICO_CREDIT_SCORE_PROOF_VERIFIER = 0x1234567890123456789012345678901234567891;
    address DEPLOYED_ADDRESS_OF_MORTGAGE_AFFORDABILITY_PROOF_VERIFIER = 0x1234567890123456789012345678901234567892;

    constructor(
        EmploymentVerificationLetterProofVerifier _employmentVerificationLetterProofVerifier,
        FICOCreditScoreProofVerifier _ficoCreditScoreProofVerifier,
        MortgageAffordabilityProofVerifier _mortgageAffordabilityProofVerifier
    ) {
        employmentVerificationLetterProofVerifier = _employmentVerificationLetterProofVerifier;
        ficoCreditScoreProofVerifier = _ficoCreditScoreProofVerifier;
        mortgageAffordabilityProofVerifier = _mortgageAffordabilityProofVerifier;
    }


    function setUp() public {
        noirHelper = new NoirHelper();

        employmentVerificationLetterProofVerifier = new EmploymentVerificationLetterProofVerifier(DEPLOYED_ADDRESS_OF_EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(DEPLOYED_ADDRESS_OF_FICO_CREDIT_SCORE_PROOF_VERIFIER);
        mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(DEPLOYED_ADDRESS_OF_MORTGAGE_AFFORDABILITY_PROOF_VERIFIER);
    }

    


}