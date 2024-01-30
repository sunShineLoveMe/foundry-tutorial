// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/MyToken.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";
import { Upgrades } from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract MyTokenTest is Test {
    MyToken myToken;
    ERC1967Proxy proxy;
    address owner;
    address newOwner;

    function setUp() public {
        MyToken implementation = new MyToken();
        // Define the owner address
        owner = vm.addr(1);
        // 部署代理合约并且初始化合约
        proxy = new ERC1967Proxy(address(implementation), abi.encodeCall(implementation.initialize, owner));
        // 通过代理合约地址创建合约实例
        myToken = MyToken(address(proxy));
        newOwner = address(1);
        emit log_address(owner);
    }

    // 测试erc20的基本功能
    function testERC20Functionality() public {
        // 模拟owner调用call
        vm.prank(owner);
        // 铸造1000个代币
        myToken.mint(address(2), 1000);
        // 断言代币总量为1000
        assertEq(myToken.balanceOf(address(2)), 1000);
    }

    // 测试升级合约
    function testUpgradeability() public {
        // 升级这个合约到新版本
        Upgrades.upgradeProxy(address(proxy), "MyTokenV2.sol:MyTokenV2", "", owner);
    }
}
