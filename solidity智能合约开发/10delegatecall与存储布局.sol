// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// delegatecall 委托调用可用于对合约的升级

// 被委托调用的合约
contract B {
    uint public num;
    address public sender;
    uint public value;
    bytes public cdata;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
        cdata = msg.data;
    }
}

// 委托调用合约    A合约委托B合约，最后改变的是 A合约的状态变量，B合约的状态变量没有发生改变
contract A {
    uint public num;
    address public sender;
    uint public value;
    bytes public cdata;

    // delegatecall 委托调用
    // 改变的是 A 的状态变量
    function setVars(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }

    // 假设 使用call调用 
    // 改变的是 B 的状态变量
    function setVarsByCall(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}