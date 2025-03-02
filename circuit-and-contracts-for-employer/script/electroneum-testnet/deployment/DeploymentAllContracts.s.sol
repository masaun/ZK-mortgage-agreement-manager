pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - ZK (Ultraplonk) circuit, which is generated in Noir.
import { UltraVerifier } from "../../../circuits/target/contract.sol"; /// @dev - Deployed-Verifier SC, which was generated based on the main.nr
import { Starter } from "../../../contracts/Starter.sol";

//import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


/**
 * @notice - Deployment script to deploy all SCs at once - on Sonic Blaze Testnet
 * @dev - [CLI]: Using the CLI, which is written in the bottom of this file, to deploy all SCs
 */
contract DeploymentAllContracts is Script {
    //using SafeERC20 for MockRewardToken;

    UltraVerifier public verifier;
    Starter public starter;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("electroneum_testnet");
        uint256 deployerPrivateKey = vm.envUint("ELECTRONEUM_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        //vm.startBroadcast();
        verifier = new UltraVerifier();
        starter = new Starter(verifier);

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Sonic Blaze Testnet
        console.logString("Logs of the deployed-contracts on Electroneum Testnet");
        console.logString("\n");
        //console.log("%s: %s", "RewardPoolFactory SC", address(rewardPoolFactory));
        //console.logString("\n");
    }
}



/////////////////////////////////////////
/// CLI (icl. SC sources) - New version
//////////////////////////////////////

// forge script script/DeploymentAllContracts.s.sol --broadcast --private-key <SONIC_BLAZE_TESTNET_PRIVATE_KEY> \
//     ./circuits/target/contract.sol:UltraVerifier \
//     ./Starter.sol:Starter --skip-simulation
