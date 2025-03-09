pragma solidity ^0.8.17;

import "../../contracts/borrower/MortgageAffordabilityProofVerifier.sol";
import { UltraVerifier } from "../../contracts/borrower/circuit/plonk_vk.sol";
//import "../../circuits/circuit-for-borrower/target/contract.sol";
import "forge-std/console.sol";

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";


contract MortgageAffordabilityProofVerifierTest is Test {
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;
    UltraVerifier public verifier;
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
        verifier = new UltraVerifier();
        mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(verifier);
    }

    function test_verifyProof() public {
        uint256[] memory hash_path = new uint256[](2);
        hash_path[0] = 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8;
        hash_path[1] = 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77;

        bytes32[] memory hash_path_bytes32 = new bytes32[](2);
        hash_path_bytes32[0] = bytes32(hash_path[0]);
        hash_path_bytes32[1] = bytes32(hash_path[1]);

        noirHelper.withInput("root", bytes32(uint256(0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629)))
                  .withInput("hash_path", hash_path_bytes32)
                  //.withInput("hash_path", hash_path)
                  .withInput("index", bytes32(uint256(0)))
                  .withInput("secret", bytes32(uint256(1))) /// @dev - [NOTE]: 'Field' type in Noir must be the form of this (= bytes32(uint256(XXX))).
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("fico_credit_score_proof", bytes32(uint256(0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("fico_credit_score_proof_hash", bytes32(uint256(0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("employment_verification_letter_proof", bytes32(uint256(0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("employment_verification_letter_proof_hash", bytes32(uint256(0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("credit_score", bytes32(uint256(800)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("income", bytes32(uint256(55000)));

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_verifyProof", 2);
        mortgageAffordabilityProofVerifier.verifyEqual(proof, publicInputs);
    }

    function test_wrongProof() public {
        noirHelper.clean();

        uint256[] memory hash_path = new uint256[](2);
        hash_path[0] = 0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8;
        hash_path[1] = 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77;

        bytes32[] memory hash_path_bytes32 = new bytes32[](2);
        hash_path_bytes32[0] = bytes32(hash_path[0]);
        hash_path_bytes32[1] = bytes32(hash_path[1]);

        noirHelper.withInput("root", bytes32(uint256(0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629)))
                  .withInput("hash_path", hash_path_bytes32)
                  //.withInput("hash_path", hash_path)
                  .withInput("index", bytes32(uint256(0)))
                  .withInput("secret", bytes32(uint256(1))) /// @dev - [NOTE]: 'Field' type in Noir must be the form of this (= bytes32(uint256(XXX))).
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("fico_credit_score_proof", bytes32(uint256(0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("fico_credit_score_proof_hash", bytes32(uint256(0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("employment_verification_letter_proof", bytes32(uint256(0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("employment_verification_letter_proof_hash", bytes32(uint256(0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("credit_score", bytes32(uint256(800)))
                  .withStruct("mortgageLoanAssessmentData")
                  .withStructInput("income", bytes32(uint256(55000)));

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_wrongProof", 2);

        /// @dev - This should fail because the public input is wrong
        bytes32[] memory fakePublicInputs = new bytes32[](2);
        fakePublicInputs[0] = publicInputs[0];
        fakePublicInputs[1] = bytes32(uint256(0xddddd));  // @dev - This is wrong publicInput ("nulifieir")

        vm.expectRevert();
        mortgageAffordabilityProofVerifier.verifyEqual(proof, fakePublicInputs);
    }

    // function test_all() public {
    //     // forge runs tests in parallel which messes with the read/writes to the proof file
    //     // Run tests in wrapper to force them run sequentially
    //     verifyProof();
    //     wrongProof();
    // }

}
