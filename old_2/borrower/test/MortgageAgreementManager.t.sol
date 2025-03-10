pragma solidity ^0.8.17;

import { EmploymentVerificationLetterProofVerifier } from "../../employer/contracts/EmploymentVerificationLetterProofVerifier.sol";
import { FICOCreditScoreProofVerifier } from "../../FICO/contracts/FICOCreditScoreProofVerifier.sol";
import { MortgageAffordabilityProofVerifier } from "../contracts/MortgageAffordabilityProofVerifier.sol";

import { DeployerOfUltraVerifierForEmploymentVerificationLetterProof } from "./local-network/DeployerOfUltraVerifierForEmploymentVerificationLetterProof.sol";
import { DeployerOfUltraVerifierForFICOCreditScoreProof } from "./local-network/DeployerOfUltraVerifierForFICOCreditScoreProof.sol";
import { DeployerOfUltraVerifierForMortgageAffordabilityProof } from "./local-network/DeployerOfUltraVerifierForMortgageAffordabilityProof.sol";

import { DataTypes } from "../contracts/libraries/DataTypes.sol";

import { NoirHelper } from "foundry-noir-helper/NoirHelper.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract MortgageAffordabilityProofVerifierTest is Test {
    NoirHelper public noirHelper;
    EmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    FICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;

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
        ultraVerifierForMortgageAffordabilityProof = new UltraVerifier();

        employmentVerificationLetterProofVerifier = new EmploymentVerificationLetterProofVerifier(DeployerOfUltraVerifierForEmploymentVerificationLetterProof.deployUltraVerifierForEmploymentVerificationLetterProof());
        ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(DeployerOfUltraVerifierForFICOCreditScoreProof.deployUltraVerifierForFICOCreditScoreProof());
        mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(DeployerOfUltraVerifierForMortgageAffordabilityProof.deployUltraVerifierForMortgageAffordabilityProof());
        console.logString(address(employmentVerificationLetterProofVerifier));
        console.logString(address(ficoCreditScoreProofVerifier));
        console.logString(address(mortgageAffordabilityProofVerifier));
    }

    


}