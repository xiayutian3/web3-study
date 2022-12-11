// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TestContract1{
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;


    //在部署的时候 可以发送主币 payable
    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    // function deploy(bytes memory _code) external payable {
    //     new TestContract1(); //部署合约的一种方式，部署TestContract2就得修改代码，重新部署代理合约
    // }

    // 部署合约的另一种方式
    event Deploy(address);
    function deploy(bytes memory _code) external payable returns(address addr){
      assembly {
        //   create(v,p,n)
        //   v = amount of ETH to send
        //   p = pointer in memory to start of code
        //   n = size of code
          addr := create(callvalue(), add(_code,0x20),mload(_code))
      }
      require(addr != address(0),"deploy failed");

      emit Deploy(addr);
    }

    // 因为代理合约有收到主币的可能性，所以添加fallback，不然会报错
    fallback() external payable {}
    receive() external payable {}

    // 执行方法，调用合约1的setOwner方法 设置合约1的管理员
    // 目标地址_target：调用合约1，传入参数_data： 调用合约1的setOwner(address _owner)+传入的参数的16进制编码
    function execute(address _target,bytes memory _data) external payable {
        (bool success,) = _target.call{value: msg.value}(_data);
        require(success,"failed");
    }
}


// 助手合约
contract Helper {
    // 获取TestContract1的字节码
    function getBytecode1() external pure returns(bytes memory){
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }
    // 获取TestContract2的字节码
    function getBytecode2(uint _x,uint _y) external pure returns(bytes memory){
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_x,_y));
    }

    // 调用TestContract1设置管理员的方法 + 传入的参数  
    function getCalldata(address _owner) external pure returns (bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}