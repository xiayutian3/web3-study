// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public isFriend;

    function example() external {
        balances[msg.sender] = 123;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)]; //返回值 0

        balances[msg.sender] +=456; // 123+456 = 579
        delete balances[msg.sender]; // 变成默认值 0 ，并不会真的删除

        // msg.sender 调用者地址    address(this)合约地址
        isFriend[msg.sender][address(this)] = true;
    }
}