// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;


contract TestFixed {
    //1.测试算数运算
    function test1(uint a,uint b) public pure returns(uint,uint){
        return (a**b,a%b);
    }

    //2.测试自增和自减
    function test2(uint _a) public pure returns(uint,uint){
        uint _c = _a++;
        return (_c,_a);
    }

    //3.整型字面量 截断问题
    // 3.1.除法用变量去运算的时候会被截断，余数丢弃
    function test3() public pure returns(uint8){
        uint8 a= 10;
        uint8 b = 3;
        return a/b; // 3
    }
     // 3.2.除法直接用整型去运算的时候，不截断
    function test4() public pure returns(uint8){
        uint8 a= 1/3*3;
        return a; // 1
    }
}