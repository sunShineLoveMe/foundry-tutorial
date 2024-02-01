// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { MyContract } from '../src/MyContract.sol';
import { Test } from 'forge-std/Test.sol';

contract MyContractTest is Test {
    MyContract exampleContract;

    function setUp() public {
        exampleContract = new MyContract();
    }

     function testIsAlwaysZeroFuzz(uint256 randomData) public {
        // uint256 data = 0; // commented out line
        exampleContract.doStuff(randomData);
        assert(exampleContract.shouldAlwaysBeZero() == 0);
    }

    // function testIsAlwaysZeroUnit() public {
    //     uint256 data = 0;
    //     exampleContract.doStuff(data);
    //     assert(exampleContract.shouldAlwaysBeZero() == 0);
    // }
}