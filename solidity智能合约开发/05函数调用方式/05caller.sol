// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// //第一种通过导入合约当做类型，然后调用合约中的函数
// import "./05callee.sol"; //导入  Callee 合约

// 第二种通过定义interface接口（这种方式应用广泛，解耦）
interface MyCallee {
     function setx(uint _x) external;
}

contract Caller {
    address public calleeAddress;

    constructor(address ca){
        calleeAddress = ca;
    }
    // 第一种方式调用
    // function setCalleex(uint _x) external {
    //     Callee callee = Callee(calleeAddress); //转换为 Callee 的地址合约调用，用 Callee类型去重载地址
    //     callee.setx(_x);
    // }

    // 第二种方式调用 定义interface接口
    function setCalleex(uint _x) external {
        MyCallee callee = MyCallee(calleeAddress); //转换为 MyCallee 的地址合约调用,用 MyCallee类型去重载地址
        callee.setx(_x);
    }
}