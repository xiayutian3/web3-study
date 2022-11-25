// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 3.继承的合约有父子关系
// 从大范围 -》 小范围 的顺序排列
contract X{

}
contract A is X {

}


contract C is X,A{

}
