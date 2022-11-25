// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 合约的销毁（合约的生命周期）
// 1.合约创建（new、sdk）
// 2.合约的操作、使用（调用函数实现功能）
// 3.合约销毁（区块链上的关于合约的存储和代码会被删除）
// 4.合约发起者才可以销毁合约

contract TestSelfedStructContract {
    address owner;
    uint num = 10;
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
    function kill() public onlyOwner {
        selfdestruct(msg.sender); //销毁合约
    }
    function getNum() public view returns(uint){
        return num;
    }
}