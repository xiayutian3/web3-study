// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 接口（interface） 更强的约束
// 1.接口关键字： interface
// 2.接口中所有的函数必须是抽象函数，所以可以省略virtual关键字
// 3.其他限制
//     3.1不能继承其他合约或接口
//     3.2不能定义构造函数
//     3.3不能定义状态变量
//     3.4不能定义结构体
//     3.5不能定义枚举类型
// 4.接口的函数可见性修饰必须使用 external

interface Father {
    function eat() external pure;
}

contract Son is Father {
    function eat() public pure override{

    }
}
