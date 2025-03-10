pragma solidity ^0.8.17;

import { EmploymentVerificationLetterProofVerifier } from "../../employer/contracts/EmploymentVerificationLetterProofVerifier.sol";
import { FICOCreditScoreProofVerifier } from "../../FICO/contracts/FICOCreditScoreProofVerifier.sol";
import { MortgageAffordabilityProofVerifier } from "./MortgageAffordabilityProofVerifier.sol";

import { DataTypes } from "./libraries/DataTypes.sol";

/**
 * @title MortgageAgreementManager contract
 */
contract MortgageAgreementManager {
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;

    mapping(bytes => DataTypes.EmploymentVerificationLetterProofAndPublicInput) public employmentVerificationLetterProofsAndPublicInputs;
    mapping(bytes => DataTypes.FICOCreditScoreProofAndPublicInput) public ficoCreditScoreProofsAndPublicInputs;
    mapping(bytes => DataTypes.MortgageAffordabilityProofAndPublicInput) public mortgageAffordabilityProofsAndPublicInputs;

    constructor(MortgageAffordabilityProofVerifier _mortgageAffordabilityProofVerifier) {
        mortgageAffordabilityProofVerifier = _mortgageAffordabilityProofVerifier;
    }

    function storeEmploymentVerificationLetterProof(bytes calldata proof, bytes32[] calldata publicInputs) public returns (bool) {
        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = employmentVerificationLetterProofVerifier.verifyEqual(proof, publicInputs);
        require(proofResult, "Proof is not valid");

        /// @dev - [TODO]: Implement the logic to store the employment verification letter proof.
        employmentVerificationLetterProofsAndPublicInputs[proof] = DataTypes.EmploymentVerificationLetterProofAndPublicInput({
            proof: proof,
            publicInput: publicInputs
        });
    }

    function storeFICOCreditScoreProof(bytes calldata proof, bytes32[] calldata publicInputs) public returns (bool) {
        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = ficoCreditScoreProofVerifier.verifyEqual(proof, publicInputs);
        require(proofResult, "Proof is not valid");

        /// @dev - [TODO]: Implement the logic to store the FICO credit score proof.
        ficoCreditScoreProofsAndPublicInputs[proof] = DataTypes.FICOCreditScoreProofAndPublicInput({
            proof: proof,
            publicInput: publicInputs
        });
    }

    function createNewMortgageAgreement(bytes calldata proof, bytes32[] calldata publicInputs) public returns (bool) {
        /// @dev - [TODO]: Get the proof/publicInput data from the mapping storage of the employment verification letter and FICO credit score.

        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = mortgageAffordabilityProofVerifier.verifyEqual(proof, publicInputs);
        require(proofResult, "Proof is not valid");
        
        /// @dev - [TODO]: Implement the logic to create a new mortgage agreement.
    }
}
