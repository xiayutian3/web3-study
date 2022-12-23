// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

// selfdestruct
//     - delete contract
//     - force send Ether to any address

contract Kill {
    //初始化接受主币
    constructor () payable {}

    // 自毁合约，强制发送剩余主币 给 msg.sender
    function kill() external {
        selfdestruct(payable(msg.sender));
    }
    function testCall() external pure returns(uint){
        return 123;
    }
}

contract Helper {
    //获取当前合约的余额 
    function getBalance() external view returns (uint){
        return address(this).balance;
    }

    // 调用合约的自毁函数
    function kill(Kill _kill) external {
        _kill.kill();
    }
}