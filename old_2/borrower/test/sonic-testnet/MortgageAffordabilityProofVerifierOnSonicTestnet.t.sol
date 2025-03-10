pragma solidity ^0.8.17;

import "../../contracts/MortgageAffordabilityProofVerifier.sol";
import { UltraVerifier } from "../../contracts/circuit/plonk_vk.sol";
//import "../../circuits/circuit-for-borrower/target/contract.sol";
import "forge-std/console.sol";

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";


contract MortgageAffordabilityProofVerifierOnSonicTestnetTest is Test {
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;
    UltraVerifier public verifier;
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
        
        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_ON_SONIC_TESTNET");
        address STARTER = vm.envAddress("MORTGAGE_AFFORDABILITY_PROOF_VERIFIER_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        mortgageAffordabilityProofVerifier = MortgageAffordabilityProofVerifier(STARTER);
        //starter = new Starter(verifier);
    }

    function test_verifyProof() public {
        noirHelper.withInput("x", 1).withInput("y", 1).withInput("return", 1);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_verifyProof", 2);
        mortgageAffordabilityProofVerifier.verifyEqual(proof, publicInputs);
    }

    function test_wrongProof() public {
        noirHelper.clean();
        noirHelper.withInput("x", 1).withInput("y", 5).withInput("return", 5);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_wrongProof", 2);
        vm.expectRevert();
        mortgageAffordabilityProofVerifier.verifyEqual(proof, publicInputs);
    }

    // function test_all() public {
    //     // forge runs tests in parallel which messes with the read/writes to the proof file
    //     // Run tests in wrapper to force them run sequentially
    //     verifyProof();
    //     wrongProof();
    // }

}
