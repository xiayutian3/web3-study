// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

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

/*
合约继承的顺序

          E
        /   \
        F    G
        \   /
          H

*/
contract E {
    // 事件
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }
    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override{
        emit Log("F.foo");
        E.foo(); //调用父级合约函数
    }
    function bar() public virtual override{
        emit Log("F.bar");
        super.bar(); //调用父级合约函数
    }
}

contract G is E {
    function foo() public virtual override{
        emit Log("G.foo");
        E.foo(); //调用父级合约函数
    }
    function bar() public virtual override{
        emit Log("G.bar");
        super.bar(); //调用父级合约函数
    }
}

contract H is F,G{
    // override(F,G) 里面的顺序无所谓
    function foo() public override(F,G) {
        F.foo();  // H.foo -> F.foo" -> E.foo"
    }
    function bar() public override(F,G) {
        super.bar(); //  H.bar -> G.bar" ->  F.bar" -> E.bar",  E.bar 只会执行一次，并不会执行两次
    }
}


