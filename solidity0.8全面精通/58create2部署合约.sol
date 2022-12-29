// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

// 之前的new方法在工厂合约里部署合约，地址值是通过 工厂合约的地址 + 工厂合约对外发出的交易的nonce值计算出来的


// // create2方法：
//     可以部署合约
//     可以提前预测被部署合约的地址
//     工厂合约的地址 + salt（盐） + 被部署合约的ABI机器码      再uint160() 计算出来的



//被部署的合约
contract DeployWithCreate2 {
    address public owner;
    constructor(address _owner){
        owner = _owner;
    }
}

//用工厂函数来部署
contract Create2Factory {
    event Deploy(address addr);

    // 部署方法
    function deploy(uint _salt) external {
        // // 以前的new方法
        // DeployWithCreate2 _contract = new DeployWithCreate2(msg.sender);
        // emit Deploy(address(_contract));
 
        // create2方法：
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt:bytes32(_salt) //加盐，类型bytes32
        }(msg.sender);
        emit Deploy(address(_contract));
    }

    // 预测地址函数
    function getAddress(bytes memory bytecode, uint _salt) public view returns (address){
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), _salt, keccak256(bytecode)
            )
        );

        return address(uint160(uint(hash))); //uint160 是地址的标准格式
    }

    // 获取被部署合约的机器码，含有构造函数
    function getBytecode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}
