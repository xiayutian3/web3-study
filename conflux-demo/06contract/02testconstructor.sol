// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 构造函数
//     有参构造
//     无参数构造

contract TestConstructor {
    // uint age = 0;
    // // 无参数构造
    // constructor () public {

    // } 

//    有参构造
    // constructor(uint _age) public {
    //     age = _age
    // }



    // 小案例
    // 只有合约的发起者可以修改，其他人没有权限
    address owner;
    string name;
    constructor() public {
        owner = msg.sender; //合约的部署者
        name = "hello";
    }

    // 修改名字
    function changName( string memory _name) public {
        require(owner == msg.sender); //合约的调用者,require错误处理
        name = _name;
    }

    // 获取名字
    function getName() public view returns(string memory){
        return name;
    }

}