// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract AbiDecode {
    // 结构体(类似于元组类型，使用复杂的二维数组)
    // 在remix中输入 ["solidity",[4,6]]
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    // abi编码
    function encode(uint x, address addr, uint[] calldata arr, MyStruct calldata myStruct) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    // abi解码 （一定需要知道数据的类型，不然无法解码）
    function decode(bytes calldata data) external pure returns (uint x, address addr, uint[] memory arr, MyStruct memory myStruct){
        (x, addr, arr, myStruct) = abi.decode(data,(uint, address, uint[], MyStruct));
    }
}