// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/OwnerUpOnly.sol";

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;

    function setUp() public  {
        upOnly = new OwnerUpOnly();
    }

    function test_IncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    function testFail_IncrementAsNotOwner() public {
        vm.prank(address(0));
        upOnly.increment();
    }
}
