// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

// 函数直接调用 、内部调用

contract B {
    uint public num;
    address public sender;
    uint public value;
    bytes public cdata;

    // 外部调用 ：外部账号调用 a函数
    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
        cdata = msg.data;
        // cdata 代表  abi.encodeWithSignature("setVars(uint256)", _num); 的二进制编码
        //remix编辑器的calldata赋值结果 0x6466414b000000000000000000000000000000000000000000000000000000000000007b
        //cdata的结果 0x6466414b000000000000000000000000000000000000000000000000000000000000007b
    }

    // 内部调用： 外部账号调用 b 函数，b函数内部调用 a 函数 ,此时的msg.data 是 b 函数的函数签名
    function setVarsIndirect(uint _num) public payable {
        setVars(_num);
    }


}