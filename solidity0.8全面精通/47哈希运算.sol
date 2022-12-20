// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// keccak256 哈希函数 返回固定长度 bytes32 数据
    // abi.encode 编码自动补0 返回不固定长的bytes
    // abi.encodePacked 编码不会补0，压缩  返回不固定长的bytes

contract HashFunc {
    function hash(string memory text, uint num ,address addr) external pure returns (bytes32){ // bytes固定长的时候  不需要 memory
        return keccak256(abi.encodePacked(text,num,addr)); //返回固定长度 bytes32 数据
    }

    function encode (string memory text0,string memory text1) external pure returns (bytes memory ){ //bytes不固定长的时候  需要添加 memory
       return abi.encode(text0,text1);  //返回不固定长的bytes
    }
    function encodePacked (string memory text0,string memory text1) external pure returns (bytes memory ){ //bytes不固定长的时候  需要添加 memory
       return abi.encodePacked(text0,text1);  //返回不固定长的bytes
    }

    function collision(string memory text0, string memory text1) external pure returns (bytes32) {
        return keccak256(abi.encode(text0,text1));
    }
}