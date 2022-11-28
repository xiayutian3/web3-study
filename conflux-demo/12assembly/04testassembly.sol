// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 九、函数声明与调用 solidity 内联汇编中声明函数

contract TestAssembly {

    function test()public pure{
        assembly {
            // 定义函数
            function sum(a,b) -> result {

            }
            //调用函数
            let temp := sum(1,2)
        }
    }
}