pragma solidity ^0.8.17;

import { UltraVerifier } from "../../../FICO/contracts/circuit/plonk_vk.sol";

library DeployerOfUltraVerifierForFICOCreditScoreProof {
    UltraVerifier public verifier;

    function deployUltraVerifierForFICOCreditScoreProof() public returns (UltraVerifier _verifier) {
        verifier = new UltraVerifier();
        return verifier;
    }
}