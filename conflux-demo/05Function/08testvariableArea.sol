// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
// 函数 状态变量，局部变量  （作用域）

contract TestVariableArea {
    uint public a = 1;

    function test(uint a) public pure returns(uint){
        a = 10;  //局部变量
        return a;
    }
    function getA() public view returns(uint){
        return a; //状态变量
    }
}
