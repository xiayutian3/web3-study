// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Solidity supports multiple inheritance. Contracts can inherit other contract by using the is keyword.
// Function that is going to be overridden by a child contract must be declared as virtual.
// Function that is going to override a parent function must use the keyword override.
// Order of inheritance is important.
// You have to list the parent contracts in the order from “most base-like” to “most derived”.

/* Graph of inheritance
    A
   / \
  B   C
 / \ /
F  D,E

*/

// 测试继承合约
// 1.状态变量只有 private 的时候可以出现重名
// 2.函数只有virtual + override可以实现重名
// 3.事件Event，修饰器modifier都不能重名
// 4.interface中的函数隐含virtual
// 5.abstract contract中无体函数必须virtual

interface MyInterface {
    function foo() external;
}
abstract contract MyInterContruct {
    function foo1() external {

    }
    function foo() external virtual;
}
contract MyA {
    // event Owner();
    // modifier demoModi(){
    //     _;
    // }

    uint private x;
    function foo() internal virtual {}
}

contract MyB is MyA {
    // event Owner();
    // modifier demoModi(){
    //     _;
    // }

    uint private x;
    function foo() internal override {}
}

// 继承的状态变量占位情况
contract ZhanweiA {
    // uint a = 123; //slot0  占32bytes
    bytes1 c;  //slot0   剩余31bytes，与继承的bytes1 d，放到了一起

}
contract ZhanweiB is ZhanweiA {
    // uint b = 123; //slot1  占32bytes
    bytes1 d;  //slot0   剩余30bytes
}


contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// Contracts inherit other contracts by using the keyword 'is'.
contract B is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Contracts can inherit from multiple parent contracts.
// When a function is called that is defined multiple times in
// different contracts, parent contracts are searched from
// right to left, and in depth-first manner.

contract D is B, C {
    // D.foo() returns "C"
    // since C is the right most parent contract with function foo()
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B"
    // since B is the right most parent contract with function foo()
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// Inheritance must be ordered from “most base-like” to “most derived”.
// Swapping the order of A and B will throw a compilation error.
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}