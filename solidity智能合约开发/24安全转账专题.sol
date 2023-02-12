// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SelfDestructTest {
    // 初始化接受以太币
    constructor() payable {}

    //销毁合约，将合约中剩余的以太币转到某个账户中
    function killMe( address to) public {
        selfdestruct(payable(to));
    }
}