
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 笔记：
// super关键字：指的是c3序列化中某个合约的前驱，而不是该合约的超类（父类）！
//         a
//     /   \   \
//    b    c    e
//    \    /    /
//       d     f
//       \    / 
//          g

// c3线性规则：(例子：g is d,f 的继承顺序，d is b,c 的继承顺序)
// 1.more-abstract-like to more-dirved
// 2.兄弟之间的顺序被代码规定了
// 3.Deterministic

// solidity c3线性序列化的结果: g-f-e-d-c-b-a
// 所以例子中的e的super是指向d的


// Parent contracts can be called directly, or by using the keyword super.
// By using the keyword super, all of the immediate parent contracts will be called.

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    // This is called an event. You can emit events from your function
    // and they are logged into the transaction log.
    // In our case, this will be useful for tracing function calls.
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo called");
    }

    function bar() public virtual {
        emit Log("A.bar called");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}

contract D is B, C {
    // Try:
    // - Call D.foo and check the transaction logs.
    //   Although D inherits A, B and C, it only called C and then A.
    // - Call D.bar and check the transaction logs
    //   D called C, then B, and finally A.
    //   Although super was called twice (by B and C) it only called A once.

    function foo() public override(B, C) {
        super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}