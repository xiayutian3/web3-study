// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 函数
// 1.格式

// 2..函数的作用
        // 1.与区块链交互
        // 2.代码封账
        // 3.代码复用
// 3.函数的参数
        // 1.形参，实参
        // 2.命名参数
// 4.函数的调用方式，函数的可见性
//     internal：状态变量、函数
//     external 函数
//     public：状态变量、函数
//     private：状态变量、函数
//     1.修饰词  修饰函数或状态变量
// 调用方式
//     2.动词
//     internal(内部调用)
//     external（外部调用）
// 5.函数状态可变性
    // view：不允许修改状态
    // pure：纯函数，不允许访问或修改状态
    // payable：允许从消息调用中接收以太币
    // constant：与view相同，（0.5.0以后，不用了）一般只修饰状态变量，不允许赋值（除初始化以外）
// 6.returns(return type) 函数返回值
//     1.返回多个值
//     2.写参数的名字，会自动返回，就不需要加return 了
//     3.写参数的名字，又写了return 以最终的返回值为主
//     4.如何接受返回值



contract TestFunArgument {
    function testArgumnet(uint a,uint b) public pure returns(uint){
        return a+b;
    }
    function testCallFun() public pure returns(uint){
        return testArgumnet(2,3);
    }
    //命名参数
    function test() public pure returns(uint){
        return testArgumnet({b:1,a:3}); // a,b 的位置可以调换
    }
}