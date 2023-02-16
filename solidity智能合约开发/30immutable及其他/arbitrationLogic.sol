// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// import "hardhat/console.sol";

// 空头套利合约 的逻辑实现

contract ArbitrationLogic {
	address immutable private original;  //immutable 修饰的变量，在构造函数执行后就替换成所有的值，对占位符进行替换
	
	constructor() {
		original = msg.sender;
	}

	function arbitrate(address target, bytes memory data) external {
		require(msg.sender == original, "Only original can call this function."); 
		(bool success, ) = target.call(data);
		require(success, "Transaction failed.");
	}

}