// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 动态调用 call(低级调用)

contract Callee {
    uint public x = 0;
    uint public y ;
    
    function setx(uint _x) external {
        x = _x;
    }
    function getCallerMsgSender() public view returns (address){
        return msg.sender;
    }

    // 回退函数 fallback  ,触发情况如下
    // 1.调用不存在的函数时会触发
    // 2.向合约中发送以太坊主币的时候
    fallback() external {
        y = 500;
    }

}