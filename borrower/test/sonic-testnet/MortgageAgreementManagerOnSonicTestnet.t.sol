pragma solidity ^0.8.17;

import { IEmploymentVerificationLetterProofVerifier } from "../../../contracts/interfaces/employer/IEmploymentVerificationLetterProofVerifier.sol";
import { IFICOCreditScoreProofVerifier } from "../../contracts/interfaces/FICO/IFICOCreditScoreProofVerifier.sol";
//import { FICOCreditScoreProofVerifier } from "../../../FICO/contracts/FICOCreditScoreProofVerifier.sol";
import { MortgageAffordabilityProofVerifier } from "../../contracts/MortgageAffordabilityProofVerifier.sol";
import { MortgageAgreementManager } from "../../contracts/MortgageAgreementManager.sol";

import { DataTypes } from "../../contracts/libraries/DataTypes.sol";

import { NoirHelper } from "foundry-noir-helper/NoirHelper.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract MortgageAgreementManagerOnSonicTestnetTest is Test {
    NoirHelper public noirHelper;

    IEmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    IFICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;
    MortgageAgreementManager public mortgageAgreementManager;

    /// @dev - Read the each deployed address from the configuration file.
    address EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = vm.envAddress("EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER_ON_SONIC_TESTNET");
    address FICO_CREDIT_SCORE_PROOF_VERIFIER = vm.envAddress("FICO_CREDIT_SCORE_PROOF_VERIFIER_ON_SONIC_TESTNET");
    address MORTGAGE_AFFORDABILITY_PROOF_VERIFIER = vm.envAddress("MORTGAGE_AFFORDABILITY_PROOF_VERIFIER_ON_SONIC_TESTNET");
    address MORTGAGE_AGREEMENT_MANAGER = vm.envAddress("MORTGAGE_AGREEMENT_MANAGER_ON_SONIC_TESTNET");

    function setUp() public {
        noirHelper = new NoirHelper();

        employmentVerificationLetterProofVerifier = IEmploymentVerificationLetterProofVerifier(EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        ficoCreditScoreProofVerifier = IFICOCreditScoreProofVerifier(FICO_CREDIT_SCORE_PROOF_VERIFIER);
        mortgageAffordabilityProofVerifier = MortgageAffordabilityProofVerifier(MORTGAGE_AFFORDABILITY_PROOF_VERIFIER);
        mortgageAgreementManager = MortgageAgreementManager(MORTGAGE_AGREEMENT_MANAGER);
    }

    function test_scenario() public {
        /// [TODO]:
        console.log("test");
    }

}