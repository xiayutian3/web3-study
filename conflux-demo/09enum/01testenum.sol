// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// // 枚举
// 1.作用：增强代码的可读性
// 2.基本数据类型
// 3.关键字：enum
// 4.书写不能有 ;
// 5.不能有""
// 6.不能有中文
// 7.结构可以转为uint


contract TestEnum{

    enum Sex {
        man,
        women
    }
    function useEnum() public pure returns(Sex){
        return Sex.man;
    }

    function useEnum2() public pure returns(uint){
        return uint(Sex.women);
    }
    
}