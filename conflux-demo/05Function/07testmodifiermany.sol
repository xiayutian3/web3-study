// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// modifier 修饰器  多重modifier修饰

contract TestMondifierMany {
    uint public a = 1;

    modifier myModifier1{
        a = 2;
        _;
        a = 3;
    }
     modifier myModifier2{
        a = 4;
        _;
        a = 5;
    }


    //myModifier2 的结果会放到 myModifier1里面 ，  最后的结果 是 3
    // 顺序：
    // a = 2;
    // a = 4;
    // _;
    // a = 5;
    // a = 3;

    function test1() public myModifier1 myModifier2 {

    }

    // 、、结果 5
    // a = 4;
    // a = 2;
    // _;
    // a = 3;
    // a = 5;

    function test2() public myModifier2 myModifier1 {

    }


}