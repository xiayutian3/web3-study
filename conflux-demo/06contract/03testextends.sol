// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0;

// solidity 中的继承 关键字 is  (除了private修饰外的，其他修饰都可以继承)
//     1.单继承
//     2.多继承

contract Father {
    uint money = 1000; // 默认什么修饰符都不写的话是 internal，可以被子类继承到
    string private name; //不被继承
    function eat() public pure returns(string memory){  // 也可以子类继承
        return "eating";
    }

}

contract Son is Father {
    function getMoney()public view returns(uint){
        return money;
    }
}