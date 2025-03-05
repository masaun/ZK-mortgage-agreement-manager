pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../../../circuits/circuit-for-FICO/target/contract.sol";
import "../../../contracts/FICO/FICOCreditScoreProofVerifier.sol";

contract FICOCreditScoreProofVerifierScript is Script {
    FICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sonic_blaze_testnet");
        uint256 deployerPrivateKey = vm.envUint("SONIC_BLAZE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        address FICO_CREDIT_SCORE_PROOF_VERIFIER = vm.envAddress("FICO_CREDIT_SCORE_PROOF_VERIFIER_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        ficoCreditScoreProofVerifier = FICOCreditScoreProofVerifier(FICO_CREDIT_SCORE_PROOF_VERIFIER);
        //ficoCreditScoreProofVerifier = new FICOCreditScoreProofVerifier(verifier);
    }
}
