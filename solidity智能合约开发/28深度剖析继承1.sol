
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// override 的技术内幕
// 定义：override path是从当前合约到某个非override virtual函数的路径
// 算法：
// 1.找到所有的非override virtual函数
// 2.搜索所有的override path
// 3.计算所有路径上所获得的函数的版本；如果版本不同，就要override，否则可以不覆盖

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    event Log(string message);

    function bar() public virtual {
        emit Log("A.bar called");
    }
}

contract B is A {

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}

contract C is A {


    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}

contract D is B, C {
    // 什么时候d需要去重载一个函数？
    //     当继承的超类都有一个同名函数时，d要去指明重载函数做的事

    function bar() public override(B, C) {
        super.bar();
    }
}