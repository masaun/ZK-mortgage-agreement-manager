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

    /// @dev - Read the each deployed address from the configuration file.
    address EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = vm.envAddress("EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER_ON_SONIC_TESTNET");
    address FICO_CREDIT_SCORE_PROOF_VERIFIER = vm.envAddress("FICO_CREDIT_SCORE_PROOF_VERIFIER_ON_SONIC_TESTNET");
    address MORTGAGE_AFFORDABILITY_PROOF_VERIFIER = vm.envAddress("MORTGAGE_AFFORDABILITY_PROOF_VERIFIER_ON_SONIC_TESTNET");

    function setUp() public {
        noirHelper = new NoirHelper();

        employmentVerificationLetterProofVerifier = new EmploymentVerificationLetterProofVerifier(EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(FICO_CREDIT_SCORE_PROOF_VERIFIER);
        mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(MORTGAGE_AFFORDABILITY_PROOF_VERIFIER);
    }

}