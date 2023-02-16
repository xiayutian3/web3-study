// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// import "hardhat/console.sol";

// 空头套利合约

contract BatcherV2 {
	// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1167.md
    bytes32 byteCode;
	uint n;
	address private immutable deployer;
	// 添加变量, 记录 batcher 地址
	address immutable private original;  //immutable 修饰的变量，在构造函数执行后就替换成所有的值，对占位符进行替换
	
	constructor(uint _n) {
		original = address(this);
		deployer = msg.sender;
		n = _n;
		createProxies(_n);
	}

	function createProxies(uint _n) internal {
		bytes memory miniProxy = bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(address(this)), bytes15(0x5af43d82803e903d91602b57fd5bf3));
        byteCode = keccak256(abi.encodePacked(miniProxy));  
		address proxy;
		for(uint i=0; i<_n; i++) {
	        bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
			assembly {
	            proxy := create2(0, add(miniProxy, 32), mload(miniProxy), salt)
			}
		}
	} 

	// target： airdrop的资产合约  target.claimToken()函数来进行资产的获取  ，data ：claimToken()的calldata： selector + 参数
	function execute(address target, bytes memory data) external {
		require(msg.sender == deployer, "Only deployer can call this function.");
		for(uint i=0; i<n; i++) {
	        address proxy = proxyFor(msg.sender, i);
			BatcherV2(proxy).callback(target, data); //这一步是正常的调用，代码的调用是BatcherV2合约来执行的，所以msg.sender是 BatcherV2，
		}
	}

	function callback(address target, bytes memory data) external {
		require(msg.sender == original, "Only original can call this function."); // 这个original是proxy的slot 3插槽位置 ==》 immutable修饰后，就变成了BatcherV2的地址
		(bool success, ) = target.call(data);
		require(success, "Transaction failed.");
	}


    function proxyFor(address sender, uint i) public view returns (address proxy) {
        bytes32 salt = keccak256(abi.encodePacked(sender, i));
        proxy = address(uint160(uint(keccak256(abi.encodePacked(
                hex'ff',
                address(this),
                salt,
                byteCode
            )))));
    }

}