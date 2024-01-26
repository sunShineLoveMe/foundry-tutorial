// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Safe.sol";

contract SafeTest is Test {
    Safe safe;

    receive() external payable {}

    function setUp() public {
        safe = new Safe();
    }

    function test_Withdraw() public {
        // 向 safe 转账 1 ether
        payable(address(safe)).transfer(1 ether);
        // 断言 safe 的余额为 1 ether
        uint256 preBalance = address(this).balance;
        // 调用 safe 的 withdraw 方法
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        // 断言 safe 的余额为 0 ether
        assertEq(preBalance + 1 ether, postBalance);
    }

    // 测试 safe 的 fallback 函数
    function testFuzz_Withdraw(uint256 amount) public {
        payable(address(safe)).transfer(amount);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);
    } 
}
