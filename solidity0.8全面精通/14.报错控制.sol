// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// 自定义错误，可以节约gas费，如果你的报错信息很长

contract TestError {
    //  自定义错误 函数
    error MyError(address caller,uint i);

    function testCustomError(uint _i) public view {
        if(_i > 10){
            revert MyError(msg.sender,_i);
        }
    }
}