// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

// 合约间函数调用 、内部调用

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
        // cdata 代表  abi.encodeWithSignature("setVars(uint256)", _num); 的二进制编码
    }

}

// A调用B或者通过call调用B，在B中显示的msg.data，不发生变化;
contract A {
    // 静态调用
    function setVarsB(address _contract, uint _num) public payable {
        B b = B(_contract);
        b.setVars(_num);
    }
    // 动态调用 call
    function setVarsBByCall(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.call(
            abi.encodeWithSignature("setVars(uint256)",_num)
        );
    }
}