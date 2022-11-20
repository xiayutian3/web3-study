// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestGetterFun{
  uint public a;

  //public修饰的状态变量,会自动生成 a的getter函数,0.5.0以后的版本,不再可以重写这个方法
  // function a() external view returns(uint ){
  //   return a;
  // }


  uint public array = [1,2,3];
  // //输入的是下标索引,0.5.0以后的版本,不再可以重写这个方法
  // function array(uint index) external view returns(uint){
  //   return array[index];
  // }
}


// 自动生产的getter函数可以在外部调用
contract Test{
  function test() public{
    TestGetterFun tf = new TestGetterFun();
    // 调用a的getter函数
    tf.a();
  }
}