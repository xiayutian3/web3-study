// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

// IERC20 合约标准

interface IERC20 {
    //当前合约的token总量
    function totalSupply() external view returns(uint);
    // 某个账户的当前余额
    function balanceOf(address account) external view returns (uint);
    // 把当前账户余额，由调用者发送到另一个账户中，写入方法 并触发一个转账事件，就可以查询token的流转了
    function transfer(address recipient, uint amount) external returns (bool);
    // 批准额度查询，某一个账户对另一个账户的额度有多少
    function allowance(address owner,address spender) external view returns (uint);
    // 批准
    function approve(address spender,uint amount) external returns (bool);
    // 向另一个合约存款的时候 ，与approve，allowance方法联合使用
    function transferFrom(address sender,address recipient,uint amount) external returns (bool);

    // 转账事件
    event Transfer(address indexed from, address indexed to, uint amount);
    // 批准事件
    event Approval(address indexed owner, address indexed spender, uint amount);
}


contract ERC20 is IERC20 {
    uint public totalSupply; //总的token
    mapping(address => uint) public balanceOf; //账户余额
    mapping(address => mapping(address => uint)) public allowance;  //批准额度
    string public name = "Test"; //token的名称
    string public symbol = "TEST"; //token的符号或简称
    uint8 public decimals = 18; //token的精度 一般是18

    //转账交易 recipient:接收人地址
    function transfer(address recipient, uint amount) external returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    //批准额度  spender：被批准的人
    function approve(address spender,uint amount) external returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
  
    // sender：发送者  recipient：接收者 amount：数量
    // transferFrom函数的调用者是 被批准额度的人
    // transferFrom函数的发送者是  批准额度的调用者
    function transferFrom(address sender,address recipient,uint amount) external returns (bool){
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }


    //铸造主币方法（正常来讲铸币方法应该是在构造函数中完成，这里是为了简单一些）
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0),msg.sender,amount);
    }
    // 销毁主币方法
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender,address(0),amount);
    }



}