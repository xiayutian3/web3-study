// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract Account {
    //合约部署者的地址，也就是工厂合约的地址
    address public bank;
    //管理员的地址
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

// 工厂合约
contract AccountFactory {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        // value:111 发送的主币数量  _owner 管理员账户
        Account account = new Account{value:111}(_owner);
        accounts.push(account);
    }
}