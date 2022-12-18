// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

// immutable 修饰的变量，部署后就变成常量来用，
// immutable 修饰的变量，一定要赋值，不赋值部署后就报错，
// 与constant区别：
//     变量一开始的值是不确定的，部署后才确定的变量为常量的值，
//     如果一开始就知道常量的值，可以直接使用 const 来定义
// immutable使用与不使用immutable定义的状态变量，使用后可以节约gas费

contract Immutable {
    address public immutable owner = msg.sender;

    // address public immutable owner;
    // constructor(){ //也可以在构造函数中 初始化 immutable定义的状态变量 的值
    //     owner = msg.sender;
    // }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}