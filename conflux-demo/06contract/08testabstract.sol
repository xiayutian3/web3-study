// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 
// // 抽象合约
// 1.关键字 abstract
// 2.抽象合约中 可以有抽象函数和非抽象函数
// 3.抽象函数不需要实现函数体
// 4.作用：
//     起到约束，约束继承抽象合约的子合约，必须重写抽象函数
// 5.抽象合约不能实例化


//抽象合约 
abstract contract Father {
    // 方法用 virtual修饰  抽象函数
    function eat() public pure virtual ;
}
contract Son is Father {
    // 子类实现的时候 使用override
    function eat() public pure override {
        // ...
    }
}