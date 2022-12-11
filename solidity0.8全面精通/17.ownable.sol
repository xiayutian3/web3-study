// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 案例 ：owner合约

// 状态变量 全局变量 函数修改器 函数 错误处理


contract Ownable {
    address public owner;

    // 构造函数
    constructor(){
        owner = msg.sender;
    }
    // 修饰器
    modifier onlyOwner(){
        // 错误判断
        require(msg.sender == owner,"not owner");
        _;
    }
    // 只有合约的部署者残能 设置owner的地址
    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0),"invalid address");
        owner = _newOwner;
    }   
    // 合约拥有者能调用
    function onlyOwnerCancallThisFunc() external onlyOwner {
        //code
    }
    // 任何人都能调用
    function anyOneCanCall() external {
        //code
    }
}