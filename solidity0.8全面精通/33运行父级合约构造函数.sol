// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract S {
    string public name;

    constructor(string memory _name){
        name = _name;
    }
}
contract T {
    string public text;

    constructor(string memory _text){
        text = _text;
    }
}

// 合约继承第一种方式传参方式 静态传参
contract U is S("s"), T("t") {

}

// 合约继承第二种方式传参方式  动态传参
contract V is S ,T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// 合约继承第三种方式传参方式  混合使用
contract VV is S("s") ,T {
    constructor( string memory _text) T(_text) {

    }
}

// 构造函数初始化的顺序，按照继承的顺序初始化
// S 
// T
// V0
contract V0 is S ,T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
} 
// 构造函数初始化的顺序 按照继承的顺序初始化
// S 
// T
// V1
contract V1 is S ,T {
    constructor(string memory _name, string memory _text) T(_text) S(_name)  {

    }
}
