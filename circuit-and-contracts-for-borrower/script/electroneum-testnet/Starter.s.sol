pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../../circuits/target/contract.sol";
import "../../contracts/Starter.sol";

contract StarterScript is Script {
    Starter public starter;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("electroneum_testnet");
        uint256 deployerPrivateKey = vm.envUint("ELECTRONEUM_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address ULTRA_VERIFIER = vm.envAddress("ULTRAVERIFER_CONTRACT_ADDRESS_ON_ELECTRONEUM_TESTNET");
        address STARTER = vm.envAddress("STARTER_CONTRACT_ADDRESS_ON_ELECTRONEUM_TESTNET");
        verifier = UltraVerifier(ULTRA_VERIFIER);
        //verifier = new UltraVerifier();
        starter = Starter(STARTER);
        //starter = new Starter(verifier);
    }
}
