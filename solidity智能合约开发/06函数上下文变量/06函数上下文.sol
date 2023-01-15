// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 函数中的上下文 
//     block、 transaction、 message

contract Callee {
    uint public x = 0;
    
    function setx(uint _x) external {
        x = _x;
    }
    function getCallerMsgSender() public view returns (address){
        return msg.sender;
    }
}

contract Caller {
    address public calleeAddress;

    constructor(address ca){
        calleeAddress = ca;
    }

    function getCallerMsgSender() public view returns (address){
        return msg.sender; //外部账号
    }
    function getCallerInsideMsgSender() public view returns (address){
        return getCallerMsgSender();  //外部账号
    }

    // 调用者调用这个合约，这个合约再调用另一个合约
    function getCallerOutsideMsgSender() public view returns (address){
        Callee cl = Callee(calleeAddress); //调用外部合约的函数
        return cl.getCallerMsgSender();  //此时的msg.sender 是 Caller合约的地址
    }
    

}

