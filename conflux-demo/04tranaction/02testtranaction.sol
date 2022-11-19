// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestTranaction {

    // 账户余额


    // address()   balance 都是合约特有的属性，方法，所以用 view  不能用 pure
    //合约账户
    function getBalance() public view returns(uint){
        return address(this).balance; //合约账户
    }

    //获取外部账户余额
    function getBalanceWai(address _address) public view returns(uint){
        return _address.balance; //外部账户
    }

    // transfer 转账
    function toContractAccount() public payable {
        address(this).transfer(msg.value); //给合约转账
    }

    //转账回退函数
    fallback() payable external {}
    receive() payable external{}


    // 给合约转账的另一种方式（transfer） 写法 0.5.0以后  address payable直接转账，不需要转账回退函数
    // transfer方式 转10：
    // 输入的金额不是10的话，转账报错，交易失败，操作回滚，余额不会减少
    function toContractAccount2() public payable{
        address payable _address = address(this);
        _address.transfer(10 ether); //硬编码金额
    }

    // 给合约转账的另一种方式（send） 写法 0.5.0以后  address payable直接转账，不需要转账回退函数
    // send方式 转10：
    // 输入的金额不是10的话，转账还是会成功，转账的金额是输入的金额，函数返回值是false
    function toContractAccountSned() public payable returns(bool){
        address payable _address = address(this);
        _address.send(10 ether);
    }



    // 给外部账户转账
    // 给外部地址转账 等到金额满足10了以后，再转过去，外部的账户余额才会增加10，只转5，这边扣了5，另一边还没加5，
    function testSend(address payable _address) public payable returns(bool){
        _address.send(10 ether);
    }


}