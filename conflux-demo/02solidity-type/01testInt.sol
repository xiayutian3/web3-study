// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// // 整型 以8为步进 递增
// int === int256
// uint === uint256

contract TestInt {
    // 有符号整数
    int public _i = 127;
    // 正整数 0+
    uint public _a = 12;
    function getI() public view returns(int){
        return _i;
    }
}