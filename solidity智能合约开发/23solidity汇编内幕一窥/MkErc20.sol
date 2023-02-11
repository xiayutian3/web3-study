// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 示例代码合约

contract MkErc20 {
    string public name = "MuKe Token";
    string public symbol = "$";
    uint8 public decimals = 4;
    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    function initialize(string calldata _name, string calldata _symbol, uint8 _decimals, uint _total) external {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _total;
    }

    function transfer(address to, uint amount) public returns(bool){
        address from = msg.sender;
        uint fromb = balanceOf[from];
        uint tob = balanceOf[to];
        balanceOf[from] = fromb - amount;
        balanceOf[to] = tob + amount;
        return true;
    }
}