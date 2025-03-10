pragma solidity ^0.8.17;

import "../contracts/FICOCreditScoreProofVerifier.sol";
import { UltraVerifier } from "../contracts/circuit/plonk_vk.sol";
//import "../circuits/circuit-for-FICO/target/contract.sol";
import "forge-std/console.sol";

import "forge-std/Test.sol";
import {NoirHelper} from "foundry-noir-helper/NoirHelper.sol";


contract FICOCreditScoreProofVerifierTest is Test {
    FICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    UltraVerifier public verifier;
    NoirHelper public noirHelper;

    function setUp() public {
        noirHelper = new NoirHelper();
        verifier = new UltraVerifier();
        ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(verifier);
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
                  .withInput("index", bytes32(uint256(0)))
                  .withInput("secret", bytes32(uint256(1))) /// @dev - [NOTE]: 'Field' type in Noir must be the form of this (= bytes32(uint256(XXX))).
                  .withInput("credit_score", bytes32(uint256(800)))
                  .withStruct("ficoCreditScoreInfo")        /// @dev - [NOTE]: The 'Struct' name (= FicoCreditScoreInfo struct).
                  .withStructInput("customer_name", bytes32(uint256(1)))
                  .withStructInput("customer_address", bytes32(uint256(1)))
                  .withStructInput("customer_phone_number", bytes32(uint256(1)))
                  .withStructInput("credit_score_in_struct", bytes32(uint256(800)))
                  .withStructInput("credit_score_created_date", bytes32(uint256(1741073225)));
                  //.withProjectPath("./circuits/circuit-for-FICO"); /// @dev - Custom file path for the circuit file.

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_verifyProof", 3);
        ficoCreditScoreProofVerifier.verifyFICOCreditScoreProof(proof, publicInputs);
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
                  .withInput("index", bytes32(uint256(0)))
                  .withInput("secret", bytes32(uint256(1))) /// @dev - [NOTE]: 'Field' type in Noir must be the form of this (= bytes32(uint256(XXX))).
                  .withInput("credit_score", bytes32(uint256(800)))
                  .withStruct("ficoCreditScoreInfo")        /// @dev - [NOTE]: The 'Struct' name (= FicoCreditScoreInfo struct).
                  .withStructInput("customer_name", bytes32(uint256(1)))
                  .withStructInput("customer_address", bytes32(uint256(1)))
                  .withStructInput("customer_phone_number", bytes32(uint256(1)))
                  .withStructInput("credit_score_in_struct", bytes32(uint256(800)))
                  .withStructInput("credit_score_created_date", bytes32(uint256(1741073225)));
                  //.withProjectPath("./circuits/circuit-for-FICO"); /// @dev - Custom file path for the circuit file.

        (bytes32[] memory publicInputs, bytes memory proof) = noirHelper.generateProof("test_wrongProof", 3);

        /// @dev - This should fail because the public input is wrong
        uint256 fake_credit_score = 2000;
        bytes32[] memory fakePublicInputs = new bytes32[](3);
        fakePublicInputs[0] = publicInputs[0];
        fakePublicInputs[1] = bytes32(uint256(fake_credit_score));  // @dev - This is wrong publicInput ("fake_credit_score") - when this proof was geneerated.
        fakePublicInputs[2] = publicInputs[2];

        vm.expectRevert();
        ficoCreditScoreProofVerifier.verifyFICOCreditScoreProof(proof, fakePublicInputs);
    }

    // function test_all() public {
    //     // forge runs tests in parallel which messes with the read/writes to the proof file
    //     // Run tests in wrapper to force them run sequentially
    //     verifyProof();
    //     wrongProof();
    // }

}
