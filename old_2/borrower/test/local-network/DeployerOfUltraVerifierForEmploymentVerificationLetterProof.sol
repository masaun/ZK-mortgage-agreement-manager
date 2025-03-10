pragma solidity ^0.8.17;

import { UltraVerifier } from "../../../employer/contracts/circuit/plonk_vk.sol";

library DeployerOfUltraVerifierForEmploymentVerificationLetterProof {
    UltraVerifier public verifier;

    function deployUltraVerifierForEmploymentVerificationLetterProof() public returns (UltraVerifier _verifier) {
        verifier = new UltraVerifier();
        return verifier;
    }
}