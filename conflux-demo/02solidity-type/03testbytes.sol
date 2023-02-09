// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
//bytes1 === byte  定长字节数组，也可以直接使用 byte
contract TestBytesl {
    // 16进制 一个16进制占0.5字节，0x01刚好是 1个字节 占 8位，  1个byte占8位 
    bytes1 _b = 0x01;
    bytes1 _a = hex"01"; //也可以这么表示
    bytes2 _bc = "bc"; // 分别将 b c 转成16进制
    bytes3 _abc = "abc";

    // bytes1 默认等于 byte
    function getABC() public view returns (bytes3 ab){
        return _abc;
    }
} 