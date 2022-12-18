// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract Payable {
    // // 定义可以发送主币的合约地址
    // address payable public owner;
    // constructor (){
    //     owner = payable(msg.sender);  //msg.sender的地址也要加上payable属性
    // }

    //payable 标记 接收以太坊主币函数
    function deposit() external payable {}

    //获取本合约的余额
    function getBalence() external view returns(uint){
        return address(this).balance;
    }
} 