// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Callee {
    uint public x = 0;
    
    function setx(uint _x) external {
        x = _x;
    }
}