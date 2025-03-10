pragma solidity ^0.8.17;

import { UltraVerifier } from "../../contracts/circuit/plonk_vk.sol";

library DeployerOfUltraVerifierForMortgageAffordabilityProof {
    UltraVerifier public verifier;

    function deployUltraVerifierForMortgageAffordabilityProof() public returns (UltraVerifier _verifier) {
        verifier = new UltraVerifier();
        return verifier;
    }
}