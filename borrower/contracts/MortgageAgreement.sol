pragma solidity ^0.8.17;

import { MortgageAffordabilityProofVerifier } from "./MortgageAffordabilityProofVerifier.sol";

contract MortgageAgreement {
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;

    constructor(MortgageAffordabilityProofVerifier _mortgageAffordabilityProofVerifier) {
        mortgageAffordabilityProofVerifier = _mortgageAffordabilityProofVerifier;
    }

    function createNewMortgageAgreement(bytes calldata proof, bytes32[] calldata publicInputs) public returns (bool) {
        /// @dev - Check whether or not a give proof is a valid proof.
        bool proofResult = mortgageAffordabilityProofVerifier.verifyEqual(proof, publicInputs);
        require(proofResult, "Proof is not valid");
        
        /// @dev - [TODO]: Implement the logic to create a new mortgage agreement.
    }
}
