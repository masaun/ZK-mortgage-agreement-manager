pragma solidity ^0.8.17;

import "./circuit/plonk_vk.sol";
//import "../../circuits/circuit-for-borrower/target/contract.sol";

contract MortgageAffordabilityProofVerifier {
    UltraVerifier public verifier;

    constructor(UltraVerifier _verifier) {
        verifier = _verifier;
    }

    function verifyEqual(bytes calldata proof, bytes32[] calldata publicInputs) public view returns (bool) {
        bool proofResult = verifier.verify(proof, publicInputs);
        require(proofResult, "Proof is not valid");
        return proofResult;
    }
}
