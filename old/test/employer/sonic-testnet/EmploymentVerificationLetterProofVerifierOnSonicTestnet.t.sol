pragma solidity ^0.8.17;

import "../../../contracts/employer/EmploymentVerificationLetterProofVerifier.sol";
import { UltraVerifier } from "../../../contracts/employer/circuit/plonk_vk.sol";
//import "../../../circuits/circuit-for-employer/target/contract.sol";
import "forge-std/console.sol";

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";


contract EmploymentVerificationLetterProofVerifierOnSonicTestnetTest is Test {
    EmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    UltraVerifier public verifier;
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
        
        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        address EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = vm.envAddress("EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        employmentVerificationLetterProofVerifier = EmploymentVerificationLetterProofVerifier(EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        //employmentVerificationLetterProofVerifier = new EmploymentVerificationLetterProofVerifier(verifier);
    }

    function test_verifyProof() public {
        // string root = "0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629"
        // string index = "0"
        // string hash_path = [
        //     "0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8",
        //     "0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77"
        // ]
        // string secret = "1"
        // uint credit_score = 800

        // [ficoCreditScoreInfo] # "FICOCreditScoreInfo" struct
        // customer_name = "1"
        // customer_address = "1"
        // customer_phone_number = "1"
        // credit_score_in_struct = 800
        // credit_score_created_date = 1741073225

        // noirHelper.withInput("root", "0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629")
        //           .withInput("index", "0")
        //           .withInput("hash_path", ["0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8", "0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77"])
        //           .withInput("secret", "1")
        //           .withInput("credit_score", 800)
        //           .withInput("ficoCreditScoreInfo", "1", "1", "1", 800, 1741073225);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_verifyProof", 2);
        employmentVerificationLetterProofVerifier.verifyEqual(proof, publicInputs);
    }

    function test_wrongProof() public {
        noirHelper.clean();
        noirHelper.withInput("x", 1).withInput("y", 5).withInput("return", 5);
        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_wrongProof", 2);
        vm.expectRevert();
        employmentVerificationLetterProofVerifier.verifyEqual(proof, publicInputs);
    }

    // function test_all() public {
    //     // forge runs tests in parallel which messes with the read/writes to the proof file
    //     // Run tests in wrapper to force them run sequentially
    //     verifyProof();
    //     wrongProof();
    // }

}
