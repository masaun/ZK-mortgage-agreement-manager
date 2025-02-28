pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../circuits/target/contract.sol";
import "../contracts/Starter.sol";

contract StarterScript is Script {
    Starter public starter;
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sonic_blaze_testnet");
        uint256 deployerPrivateKey = vm.envUint("SONIC_BLAZE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        verifier = UltraVerifier(0x68fC0B89aa8591ff49065971ADFECeE42eF4cA36);
        //verifier = new UltraVerifier();
        starter = Starter(0xE4531177030A7bD88eb58c6ADEe0e4155AfCaeCf);
        //starter = new Starter(verifier);
    }
}
