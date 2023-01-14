// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

// ERC20 规范
// goerli 测试网  合约地址 0x310d53CDe701D6536707a69Bd3937BF08F3025B9

contract MyErc20Token {
    event TransferEvent(uint oldv, uint newv);//转账事件

    string public name = "BYD"; //货币名称
    string public symbol = "$"; //货币符号
    uint public decimals = 4;  //小数点的为数，小数点的精度,10的4次方， 一般是18

    mapping(address => uint) public balanceOf;  //账户余额映射
    // function balanceOf(address key) public view returns(uint){ //get函数
    //     return balanceOf[key];
    // }

    constructor (uint total) {
        balanceOf[msg.sender] = total;
    }

    //转账操作
    function transfer(address to, uint amount) public {
        address from = msg.sender;
        uint current = balanceOf[from];
        if(current <= amount){
            revert("not enough balanceOf");
        }
        uint toc = balanceOf[to];

        current -= amount;
        toc += amount;
        balanceOf[from] = current;
        balanceOf[to] = toc;
    }


    // 自毁合约，如果有余额，强制发送剩余主币 给 msg.sender， msg.sender默认没有payable属性
    function kill() external {
        selfdestruct(payable(msg.sender));
    }
}