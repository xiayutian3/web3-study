// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// import "hardhat/console.sol";
import "./arbitrationLogic.sol";

// 空头套利合约 调整版本，把逻辑合约拿了出去

contract BatcherV2 {
	// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1167.md
    bytes32 byteCode;
	uint n;
	address private immutable deployer;
	
	constructor(uint _n, address logic) {
		deployer = msg.sender;
		n = _n;
		createProxies(_n, logic);
	}

	function createProxies(uint _n, address logic) internal {
		bytes memory miniProxy = bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(logic), bytes15(0x5af43d82803e903d91602b57fd5bf3));
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
			ArbitrationLogic(proxy).arbitrate(target, data); //这一步是正常的调用，所以msg.sender是 BatcherV2，
		}
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