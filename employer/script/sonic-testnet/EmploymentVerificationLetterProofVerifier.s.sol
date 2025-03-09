pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import { UltraVerifier } from "../../contracts/circuit/plonk_vk.sol";
//import "../../circuits/circuit-for-employer/target/contract.sol";
import "../../contracts/EmploymentVerificationLetterProofVerifier.sol";

contract EmploymentVerificationLetterProofVerifierScript is Script {
    EmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sonic_blaze_testnet");
        uint256 deployerPrivateKey = vm.envUint("SONIC_BLAZE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        address EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = vm.envAddress("EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER_CONTRACT_ADDRESS_ON_SONIC_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        employmentVerificationLetterProofVerifier = EmploymentVerificationLetterProofVerifier(EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        //employmentVerificationLetterProofVerifier = new EmploymentVerificationLetterProofVerifier(verifier);
    }
}
