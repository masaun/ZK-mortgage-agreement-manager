pragma solidity ^0.8.17;

import { FICOCreditScoreProofVerifier } from "../../contracts/FICOCreditScoreProofVerifier.sol";
import { UltraVerifier } from "../../contracts/circuit/plonk_vk.sol";
//import "../../circuits/circuit-for-FICO/target/contract.sol";
import "forge-std/console.sol";

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";


contract FICOCreditScoreProofVerifierOnSonicTestnetTest is Test {
    FICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    UltraVerifier public verifier;
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
        
        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_ON_SONIC_TESTNET");
        address FICO_CREDIT_SCORE_PROOF_VERIFIER = vm.envAddress("FICO_CREDIT_SCORE_PROOF_VERIFIER_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        ficoCreditScoreProofVerifier = FICOCreditScoreProofVerifier(FICO_CREDIT_SCORE_PROOF_VERIFIER);
        //ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(verifier);
    }

    function test_verifyProof() public {
        noirHelper.withInput("x", 1).withInput("y", 1).withInput("return", 1);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_verifyProof", 2);
        ficoCreditScoreProofVerifier.verifyFICOCreditScoreProof(proof, publicInputs);
    }

    function test_wrongProof() public {
        noirHelper.clean();
        noirHelper.withInput("x", 1).withInput("y", 5).withInput("return", 5);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_wrongProof", 2);
        vm.expectRevert();
        ficoCreditScoreProofVerifier.verifyFICOCreditScoreProof(proof, publicInputs);
    }

    // function test_all() public {
    //     // forge runs tests in parallel which messes with the read/writes to the proof file
    //     // Run tests in wrapper to force them run sequentially
    //     verifyProof();
    //     wrongProof();
    // }

}
