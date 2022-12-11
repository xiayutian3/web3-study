// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract FunctionOutputs {
    function returnMany() public pure returns(uint,bool){
        return (1,true);
    }
     function returnMany1() public pure returns(uint x,bool b){
        return (1,true);
    }
    // 隐式返回
     function returnMany2() public pure returns(uint x,bool b){
        x = 1;
        b = false;
    }

    // 获取函数返回值
     function returnMany3() public pure {
         (uint x, bool b) = returnMany2();
        //  只获取后边的返回值
         (,bool c) = returnMany2();
    }
}
