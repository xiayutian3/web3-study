// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 多重继承
// 1.状态变量（多个父类合约中状态变量不能重名）
// 2.重名函数 （ 0.6.0 以后，多个父类有相同的函数名，子类必须要重写这个函数名）
// 3.继承的合约有父子关系 （从大范围 -》 小范围 的顺序排列）

contract Father{
    uint money = 1000;
    function getMoney() public pure virtual returns(uint){
        return 1000;
    }
}
contract Mother {
    // uint money = 800; //father合约已存在，不能重复定义
    function getMoney() public pure virtual returns(uint){
        return 800;
    }
}

contract Son is Father,Mother{
    // （ 0.6.0 以后，多个父类有相同的函数名，子类必须要重写这个函数名）
    function getMoney() public pure override(Father,Mother) returns(uint){
        // return 900;
        return Father.getMoney() + Mother.getMoney(); //同时获取父亲母亲的钱
    }
}



