// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

/*
A calls B ,sends 100 wei
    B calls C, sends 50 wei
A ---> B ---> C
    msg.sender = B
    msg.value = 50
    execute code on C's state variables
    use ETH in C

委托调用的方式
A calls B,ssends 100 wei
    B delegatecall C
A ---> B ---> C
    msg.sender = A
    msg.value = 100
    execute code on B's state variables
    use ETH in B
*/

contract TestDelegateCall {
    //被调用合约的类型，状态变量，顺序要与委托合约一致，
    uint public num;
    address public sender;
    uint public value;
    // 可以在这里添加多余的状态变量，但是不能在头部添加，这样会改变顺序
    uint public x;


    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}


// 委托调用合约
contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // // 和低级call的用法一样,用abi编码形式对函数签名，进行编码，再传入参数
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)",_num));

        // 另一种编码形式 使用select的形式编码 (abi.encodeWithSignature这种形式，最终也会转换成selector的形式)
       (bool success,bytes memory data) =  _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector,_num));
       require(success,"delegatecall failed");

    }
}
