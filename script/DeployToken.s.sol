// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "../src/MyToken.sol";
import "forge-std/Script.sol";

contract DeployTokenImplementation is Script {
    function run() public {
        vm.startBroadcast();
        MyToken implementation = new MyToken();

        vm.stopBroadcast();
        console.log("Implementation address: ", address(implementation));
    }
}