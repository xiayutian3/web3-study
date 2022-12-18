// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

// 回退函数的调用触发情况
// 1.当调用智能合约的函数不存在的时候
// 2.向合约中发送以太坊主币的时候

// fallback receive 8.0新增的两种回退函数
/*
        Ether is sent to contract(执行的情况)
                    |
            is msg.data empty
                /       \
                yes       no
                /           \
    receive() exists?       fallback()
            /       \
        yes          no
        /             \
    receive()      fallback()
*/


contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    // fallback 可以不加payable,但是接受主币的话，一定要加
    fallback() external payable {
        //  参数： 事件名称 事件的调用者 发送的币的数量 发送的数据（16进制数：0x1254，编辑器CALLDATA Transact那里输入的值）
        emit Log("fallback", msg.sender,msg.value,msg.data);
    }

    receive() external payable {
        emit Log("receive",msg.sender,msg.value,'');
    }

}