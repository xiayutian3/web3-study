// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0;

// solidity继承
// 父合约构造函数的传参(两种风格不能同时使用)
    // 1.继承式
    // 2.修改风格式

contract Father{
    uint private age;
    constructor(uint _age) public{
        age = _age;
    }
}

contract Son is Father(30){ //继承式

}
contract Son2 is Father{
    constructor() Father(30) public { //修改风格式

    }
}