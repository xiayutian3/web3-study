// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestGlobalValue2{
    // 1.保存合约部署者地址
    // 2.只有和与部署者可以修改钱数，其他地址不可以修改
    address onwer ;  //合约的部署者地址
    uint money;

    constructor()public{
        onwer = msg.sender; //合约的部署者地址
    }

    function changeMoney() public {
        // if(msg.sender == onwer){
        //     money += 5000;
        // }
        require(msg.sender == onwer); //错误处理函数
        money += 5000;
    }
    function getMoney() public view returns(uint){
        return money;
    }
}