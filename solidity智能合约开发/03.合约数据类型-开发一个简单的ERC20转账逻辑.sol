// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

contract NumberStorage {
    mapping(address => uint) public balance;

    constructor (uint total) {
        balance[msg.sender] = total;
    }

    //转账操作
    function transfer(address to, uint amount) public {
        address from = msg.sender;
        uint current = balance[from];
        if(current <= amount){
            revert("not enough balance");
        }
        uint toc = balance[to];

        current -= amount;
        toc += amount;
        balance[from] = current;
        balance[to] = toc;
    }
}