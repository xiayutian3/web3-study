// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// mapping类型没有memory
// 数据类型一致触发引用，类型不一致，触发拷贝

contract DataLocation {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        _f(arr, map, myStructs[1]);

        //引用一个struct变量,可以直接修改数据,状态变量数据会立即发生变化
        MyStruct storage myStruct = myStructs[1];
        myStruct.foo = 100;
        // 创建一个struct 在内存中,修改内存数据,状态变量数据不影响,除非内存数据修改了,重新赋值状态变量
        MyStruct memory myMemoryStruct = MyStruct(0);
    }

    // memory类型与storage类型
    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    )internal {
        // 1.传过来的数据类型不一致，会引发数据的拷贝
        // 2.memory类型的数据修改  不会影响  传过来的状态变量
        // 3.storage类型的数据修改  会影响  传过来的状态变量
        //do something
    }

    // 返回值 都是memory类型 
    function g(uint[] memory _arr) public returns (uint[] memory){
        //do something
    }

    // calldata只在 函数external中
    function h(uint[] calldata _arr) external {
        //do something 
    }

}

