pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../../../circuits/circuit-for-borrower/target/contract.sol";
import "../../../contracts/borrower/MortgageAffordabilityProofVerifier.sol";

contract MortgageAffordabilityProofVerifierScript is Script {
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sonic_blaze_testnet");
        uint256 deployerPrivateKey = vm.envUint("SONIC_BLAZE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        address STARTER = vm.envAddress("MORTGAGE_AFFORDABILITY_PROOF_VERIFIER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        mortgageAffordabilityProofVerifier = MortgageAffordabilityProofVerifier(STARTER);
        //mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(verifier);
    }
}
