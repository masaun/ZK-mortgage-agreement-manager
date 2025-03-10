pragma solidity ^0.8.17;

import { IEmploymentVerificationLetterProofVerifier } from "./interfaces/employer/IEmploymentVerificationLetterProofVerifier.sol";
import { IFICOCreditScoreProofVerifier } from "./interfaces/FICO/IFICOCreditScoreProofVerifier.sol";
//import { FICOCreditScoreProofVerifier } from "./FICOCreditScoreProofVerifier.sol";
import { MortgageAffordabilityProofVerifier } from "./MortgageAffordabilityProofVerifier.sol";
//import { MortgageAffordabilityProofVerifier } from "./MortgageAffordabilityProofVerifier.sol";

import { DataTypes } from "./libraries/DataTypes.sol";

/**
 * @title MortgageAgreementManager contract
 */
contract MortgageAgreementManager {
    IEmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    IFICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;

    mapping(bytes => DataTypes.EmploymentVerificationLetterProofAndPublicInput) public employmentVerificationLetterProofsAndPublicInputs;
    mapping(bytes => DataTypes.FICOCreditScoreProofAndPublicInput) public ficoCreditScoreProofsAndPublicInputs;
    mapping(bytes => DataTypes.MortgageAffordabilityProofAndPublicInput) public mortgageAffordabilityProofsAndPublicInputs;
    mapping(address => mapping (address => DataTypes.MortgageAgreement)) public mortgageAgreements;

    constructor(
        IEmploymentVerificationLetterProofVerifier _employmentVerificationLetterProofVerifier,
        IFICOCreditScoreProofVerifier _ficoCreditScoreProofVerifier,
        MortgageAffordabilityProofVerifier _mortgageAffordabilityProofVerifier
    ) {
        employmentVerificationLetterProofVerifier = _employmentVerificationLetterProofVerifier;
        ficoCreditScoreProofVerifier = _ficoCreditScoreProofVerifier;
        mortgageAffordabilityProofVerifier = _mortgageAffordabilityProofVerifier;
    }

    function storeEmploymentVerificationLetterProof(bytes calldata proof, bytes32[] calldata publicInputs) private returns (bool) {
        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = employmentVerificationLetterProofVerifier.verifyEmploymentVerificationLetterProof(proof, publicInputs);
        require(proofResult, "Proof is not valid");

        /// @dev - Store the employment verification letter proof and publicInput /w nullifier.
        bytes32 _merkleRoot = publicInputs[0];
        bytes32 _annualSalary = publicInputs[1];
        bytes32 _nullifier = publicInputs[2];
        employmentVerificationLetterProofsAndPublicInputs[proof] = DataTypes.EmploymentVerificationLetterProofAndPublicInput({
            merkleRoot: _merkleRoot,
            annualSalary: _annualSalary,
            nullifier: _nullifier,
            isNullifier: true
        });
    }

    function storeFICOCreditScoreProof(bytes calldata proof, bytes32[] calldata publicInputs) private returns (bool) {    
        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = ficoCreditScoreProofVerifier.verifyFICOCreditScoreProof(proof, publicInputs);
        require(proofResult, "Proof is not valid");

        /// @dev - Store the FICO credit score proof and publicInput /w nullifier.
        bytes32 _merkleRoot = publicInputs[0];
        bytes32 _creditScore = publicInputs[1];
        bytes32 _nullifier = publicInputs[2];
        ficoCreditScoreProofsAndPublicInputs[proof] = DataTypes.FICOCreditScoreProofAndPublicInput({
            merkleRoot: _merkleRoot,
            creditScore: _creditScore,
            nullifier: _nullifier,
            isNullifier: true
        });
    }

    /**
     * @notice - Create a request of mortgage agreement.
     * @dev - This caller is only "Borrower" (Employee).
     */
    function createRequestOfMortgageAgreement(
        address lender,
        bytes calldata employmentVerificationLetterProof, 
        bytes32[] calldata employmentVerificationLetterPublicInputs,
        bytes calldata ficoCreditScoreProof, 
        bytes32[] calldata ficoCreditScorePublicInputs,
        bytes calldata mortgageAffordabilityProof, 
        bytes32[] calldata mortgageAffordabilityPublicInputs
    ) public returns (bool) {
        /// @dev - Store the proof/publicInput data into the mapping storage of the employment verification letter and FICO credit score.
        storeEmploymentVerificationLetterProof(employmentVerificationLetterProof, employmentVerificationLetterPublicInputs);
        storeFICOCreditScoreProof(ficoCreditScoreProof, ficoCreditScorePublicInputs);

        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = mortgageAffordabilityProofVerifier.verifyMortgageAffordabilityProof(mortgageAffordabilityProof, mortgageAffordabilityPublicInputs);
        require(proofResult, "Proof is not valid");
        
        /// @dev - Store the mortgage affordability proof and publicInput /w nullifier.
        bytes32 _merkleRoot = mortgageAffordabilityPublicInputs[0];
        bytes32 _nullifier = mortgageAffordabilityPublicInputs[1];
        mortgageAffordabilityProofsAndPublicInputs[mortgageAffordabilityProof] = DataTypes.MortgageAffordabilityProofAndPublicInput({
            merkleRoot: _merkleRoot,
            nullifier: _nullifier,
            isNullifier: true
        });

        /// @dev - Create a new mortgage agreement request.
        address _borrower = msg.sender;
        mortgageAgreements[msg.sender][lender] = DataTypes.MortgageAgreement({
            borrower: _borrower,
            lender: lender,
            employmentVerificationLetterProof: employmentVerificationLetterProof,
            employmentVerificationLetterPublicInputs: employmentVerificationLetterPublicInputs,
            ficoCreditScoreProof: ficoCreditScoreProof,
            ficoCreditScorePublicInputs: ficoCreditScorePublicInputs,
            mortgageAffordabilityProof: mortgageAffordabilityProof,
            mortgageAffordabilityPublicInputs: mortgageAffordabilityPublicInputs,
            isAccepted: false
        });
    }

    /**
     * @notice - Accept a request of mortgage agreement.
     * @dev - This caller is only "Lender" (Real Estate company).
     */
    function acceptRequestOfMortgageAgreement(address borrower) public returns(bool) {
        address lender = msg.sender;
        require(lender == mortgageAgreements[borrower][lender].lender, "This lender is not matched with the lender in the mortgage agreement");
        require(mortgageAgreements[borrower][lender].isAccepted == false, "This mortgage agreement is already accepted");
        mortgageAgreements[borrower][lender].isAccepted = true;
    }
}
