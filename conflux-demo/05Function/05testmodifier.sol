// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// modifier 修饰器 （不带参数）

contract TestModifier {

    uint public a = 0;
    //create modifier
    modifier myModifier(){  //可以不带（），因为没有参数，一般没有参数不会带括号
        a = 5;
        _;  //插入的位置
        a = 8;
    }
    //call modifier
    function callModifier() public myModifier{
        a = 9;
    }
}