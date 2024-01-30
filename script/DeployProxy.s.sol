// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../src/MyToken.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "forge-std/Script.sol";

contract DeployTokenProxy is Script {
    function run() public {
        address _implementation = 0x6437C4BFdE4281Ec6C9040cB2f1b9e341f3bDAcB;
        vm.startBroadcast();
        
        bytes memory data = abi.encodeWithSelector(
            MyToken(_implementation).initialize.selector, 
            msg.sender);

        ERC1967Proxy proxy = new ERC1967Proxy(_implementation, data);

        vm.stopBroadcast();

        console.log("UUPS Proxy Address:", address(proxy));    
    }

}