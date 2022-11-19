// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestReturns{
  //返回多个值
  function testReturns() public pure returns(uint,uint){
    return (1,2);
  }
  //写参数的名字，会自动返回，就不需要加return 了
  function testReturnsArgument(uint a,uint b) public pure returns(uint sum) {
    sum = a+b;
  }

//写了return 以最终的返回值为主
  function testReturnsArgument2(uint a,uint b) public pure returns(uint sum) {
    sum = a+b;
    return 3; //sum是3，以最终的返回值为主
  }

  //写参数的名字 返回多个值，就不需要加return 了
  function testReturns2() public pure returns(uint a,uint b){
    a=1;
    b=2;
  }
}