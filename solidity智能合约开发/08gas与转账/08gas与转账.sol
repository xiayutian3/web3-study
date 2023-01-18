// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;
/*
which  function is called ,fallback() or receive()?

    send Ether(函数调用)
            |
    msg.data(calldata) is empty?
        /           \
        no            yes
        /                \
    fname() exists?     fallback()
        /   \
      yes     no
        /       \
    fname()     fallback()

*/

// 转账时，添加调用选项 {gas[gaslimit]:<gas>,value:<value>} ,gas控制gas，value转账的值。gas不指定，默认将剩余的gas全部传送过去，过函数消耗，剩余的gas会返回，gas不够会报错
// 例如：
// Address.call{value:msg.value}(""); 通过调用地址.call()方式
// contract(Address).foo{value:msg.value}(); 通过一般合约的方法



// 收款合约
contract ReceiveEther {
    // 事件
    event Fallback(bytes cdata, uint value, uint gas);
    event Foo(bytes cdata, uint value, uint gas);

    // fallback function is called when msg.data is empty 
    // payable 可以收款
    fallback() external payable {
        emit Fallback(msg.data, msg.value, gasleft()); // gasleft() 剩余的gas
    }
    receive()  external payable {

    }

    // 获取余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // 普通函数，payable可接受主币
    function foo() public payable {
        emit Foo(msg.data, msg.value, gasleft()); // gasleft() 剩余的gas
    }
}

// 发送主币合约
contract SendEther {
    // 收款函数 （只管收钱）
    function rec () public payable {

    }

    // 指定发多少钱函数，(没有payable,只管转钱)
    function sendViaCallAmount(address payable _to, uint amount) public {
        (bool sent, bytes memory data) = _to.call{value:amount}("");
        require(sent, "failed to send Ether");
    }

     // 获取余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }


    // 通过 call 来转账
    function sendViaCall(address payable _to) public payable {
        (bool sent, bytes memory data) = _to.call{value:msg.value}("");
        require(sent, "failed to send Ether");
    }

    // 通过普通函数 foo来转账
    function sendViaFoo(address payable _to) public payable {
        ReceiveEther re = ReceiveEther(_to);
        re.foo{value:msg.value}();
        //msg.value 是sendViaFoo的调用者发送给SendEther合约的钱，然后SendEther合约又调用ReceiveEther合约的foo方法，把钱给转了过去
    }
}

