// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 汇编中修改状态变量的值，返回状态变量的值

interface StorageI {
    // calldata： "readDataTest()"
    function readDataTest() external view returns(uint); //有返回值
}

contract Storage {

    uint256 number;

    //汇编中修改状态变量的值，
    function store(uint256 num) public {
        assembly{
            // 状态变量在汇编中都有个slot的成员属性，表示它的位置
            sstore(number.slot, num)
        }
    }

    //占用草稿的位置 mstore(0,),从0开始
    function read() public view returns (uint256){
        assembly {
            let result := sload(number.slot) //先加载值
            mstore(0, result) //把值存储到内存中，(不能直接返回值)
            return (0,32) // 在返回出来（32个字节来存储数据）
        }
    }

    // 不占用草稿的位置 从自由指针开始 mstore(0x40,),
    function readData() public view returns (uint256){
        assembly {
            let result := sload(number.slot) //先加载值
            let free_pointer := mload(0x40) //哈希运算的草稿位置 
            mstore(free_pointer, result) //把值存储到内存中，(不能直接返回值)，从哈希草稿位置往后存储
            return (free_pointer,32) // 在返回出来（32个字节来存储数据）
        }
    }

    //测试 该函数与interface中的定义不一致的时候,执行还是有返回值
    function readDataTest() external view { // 无返回值
        assembly {
            let result := sload(number.slot) //先加载值
            let free_pointer := mload(0x40) //哈希运算的草稿位置 
            mstore(free_pointer, result) //把值存储到内存中，(不能直接返回值)，从哈希草稿位置往后存储
            return (free_pointer,32) // 在返回出来（32个字节来存储数据）
        }
    }
}