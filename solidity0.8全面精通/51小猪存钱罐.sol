// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract PiggyBank {
    // 接收主币事件
    event Deposit(uint amount);
    // 提款事件
    event Withdraw(uint amount);

    address public owner = msg.sender;  //直接赋值管理员
    // 接收主币函数
    receive() external payable {
        emit Deposit(msg.value);
    }
    // 提款函数
    function withdraw() external {
        require(msg.sender == owner,"not owner");
        emit Withdraw(address(this).balance);
        // 为什么不用owner，而是用msg.sender，因为节约gas
        selfdestruct(payable(msg.sender));
    }
}