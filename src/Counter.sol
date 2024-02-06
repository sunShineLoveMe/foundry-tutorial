// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public counter;
    
    function setNumber(uint256 _newNumber) public {
        counter = _newNumber;
    }

    function increment() public {
        counter++;
    }

    function count() public {
        counter = counter + 1;
    }
}