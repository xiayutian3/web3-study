// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

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


