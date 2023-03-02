// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns(bytes4) {
        // keccak256里面不能放string类型，所以转bytes类型，再运算哈希
        return bytes4(keccak256(bytes(_func)));
        // 输入"transfer(address,uint256)"， 得出的结果 bytes4: 0xa9059cbb
    }
}

contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
        // msg.data :
        // 0xa9059cbb 函数的选择器，也叫函数的签名（函数名+函数的参数类型转哈希，然后取前4位16进制数），4字节的bytes类型 占8个字符
        // 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4   参数一：to地址 32字节  -》 32x8 =256位
        // 000000000000000000000000000000000000000000000000000000000000000b  参数二：11 是16进制的b 32字节  -》 32x8 =256位
    }
}