pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - ZK (Ultraplonk) circuit, which is generated in Noir.
import { UltraVerifier } from "../../../contracts/circuit/plonk_vk.sol"; /// @dev - Deployed-Verifier SC, which was generated based on the main.nr
import { MortgageAffordabilityProofVerifier } from "../../../contracts/MortgageAffordabilityProofVerifier.sol";
import { IEmploymentVerificationLetterProofVerifier } from "../../../contracts/interfaces/employer/IEmploymentVerificationLetterProofVerifier.sol";
import { IFICOCreditScoreProofVerifier } from "../../../contracts/interfaces/FICO/IFICOCreditScoreProofVerifier.sol";

import { MortgageAgreementManager } from "../../../contracts/MortgageAgreementManager.sol";

//import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


/**
 * @notice - Deployment script to deploy all SCs at once - on Sonic Blaze Testnet
 * @dev - [CLI]: Using the CLI, which is written in the bottom of this file, to deploy all SCs
 */
contract DeploymentAllContracts is Script {
    //using SafeERC20 for MockRewardToken;
    IEmploymentVerificationLetterProofVerifier public employmentVerificationLetterProofVerifier;
    IFICOCreditScoreProofVerifier public ficoCreditScoreProofVerifier;

    UltraVerifier public verifier;
    MortgageAffordabilityProofVerifier public mortgageAffordabilityProofVerifier;
    MortgageAgreementManager public mortgageAgreementManager;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sonic_blaze_testnet");
        uint256 deployerPrivateKey = vm.envUint("SONIC_BLAZE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Read the each deployed address from the configuration file.
        address EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER = vm.envAddress("EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER_ON_SONIC_TESTNET");
        address FICO_CREDIT_SCORE_PROOF_VERIFIER = vm.envAddress("FICO_CREDIT_SCORE_PROOF_VERIFIER_ON_SONIC_TESTNET");
        employmentVerificationLetterProofVerifier = IEmploymentVerificationLetterProofVerifier(EMPLOYMENT_VERIFICATION_LETTER_PROOF_VERIFIER);
        ficoCreditScoreProofVerifier = IFICOCreditScoreProofVerifier(FICO_CREDIT_SCORE_PROOF_VERIFIER);

        /// @dev - Deploy SCs
        verifier = new UltraVerifier();
        mortgageAffordabilityProofVerifier = new MortgageAffordabilityProofVerifier(verifier);
        
        mortgageAgreementManager = new MortgageAgreementManager(employmentVerificationLetterProofVerifier, ficoCreditScoreProofVerifier, mortgageAffordabilityProofVerifier);

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Sonic Blaze Testnet
        console.logString("Logs of the deployed-contracts on Sonic Blaze Testnet");
        console.logString("\n");
        console.log("%s: %s", "UltraVerifier SC", address(verifier));
        console.logString("\n");
        console.log("%s: %s", "MortgageAffordabilityProofVerifier SC", address(mortgageAffordabilityProofVerifier));
        console.logString("\n");
        console.log("%s: %s", "MortgageAgreementManager SC", address(mortgageAgreementManager));
        console.logString("\n");
    }
}



/////////////////////////////////////////
/// CLI (icl. SC sources) - New version
//////////////////////////////////////

// forge script script/DeploymentAllContracts.s.sol --broadcast --private-key <SONIC_BLAZE_TESTNET_PRIVATE_KEY> \
//     ./circuits/target/contract.sol:UltraVerifier \
//     ./MortgageAffordabilityProofVerifier.sol:MortgageAffordabilityProofVerifier --skip-simulation
