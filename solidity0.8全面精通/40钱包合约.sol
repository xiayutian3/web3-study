// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract EtherWallet {
    address payable public owner;
    constructor (){
        owner = payable(msg.sender); //设置管理员
    }

    receive() external payable {} //接受以太坊主币

    function withdraw(uint _amount) external {
        require(msg.sender == owner,"caller is not owner");
        payable(msg.sender).transfer(_amount); //给调用者转账

        // (bool sent,) = msg.sender.call{value:_amount}("");  //直接使用call，msg.sender不需要添加payable
        // require(sent,"failed to send Ether");
    }

    // 获取余额
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}