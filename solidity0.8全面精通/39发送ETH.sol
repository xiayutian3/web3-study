// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3; 

// 3 ways to send ETH
// transfer - 2300gas, reverts
// send - 2300gas, returns bool
// call - all gas , returns bool and data
 
contract SendEther {
    // 初始化 让合约中有主币，接受以太坊主币的两种方式，receive 还有fallback
    constructor() payable {}
    receive() external payable{}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123); //单位是wei
    }
    function sendViaSend(address payable _to) external payable {
       bool sent =  _to.send(123); //单位是wei
       require(sent,"send failed");
    }
    function sendViaCall(address payable _to) external payable {
        // (bool sucess,bytes memory data) 
        (bool sucess,) = _to.call{value:123}(''); //单位是wei ,call后面的括号传递的数据 ""
        require(sucess,"call failed");
    }
}

// 接受主币的智能合约
contract EthReceiver {
    event Log(uint amount , uint gas);

    // 接受其他合约发送过来的以太坊主币
    receive() external payable {
        emit Log(msg.value, gasleft()); //gasleft  剩余的gas是多少
    }
}