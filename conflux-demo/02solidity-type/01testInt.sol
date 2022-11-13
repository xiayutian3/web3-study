// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// 整型

contract TestInt {
    
    int public _i = 127;
    function getI() public view returns(int){
        return _i;
    }
}