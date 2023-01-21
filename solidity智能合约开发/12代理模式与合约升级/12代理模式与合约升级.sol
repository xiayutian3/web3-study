// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// proxy代理模式，到达了数据与逻辑分离

// 通过自定义接口使用合约  remix编辑器上，合约选择 ProxyInterface， At Address加载，要重载的合约 在这里重载的是Proxy的合约地址
interface ProxyInterface {
    function inc() external;
    function dec() external;
}

// Proxy代理合约只负责数据，其他对数据的操作交给  v1，v2合约去实现，v1,v2操作的数据是影响proxy合约的数据，v1,v2的数据不发生变化
contract Proxy {
    address public implementation;
    uint public x;

    // 实现implementation的切换，相当于升级了合约
    function setImplementtation(address _imp) external {
        implementation = _imp;
    }

    function _delegate(address _imp) internal virtual {
        (bool suc, bytes memory data) = _imp.delegatecall(msg.data);
        if(!suc){
            revert("failed");
        }
    }

    fallback() external payable {
        // 当proxy的客户端以某种方式来把proxy当作具体具有完整业务功能的合约来调用它的各种功能函数时，这些函数都会被转发给 implementation
        _delegate(implementation);
    }
}

contract V1 {
    address public implementation;
    uint public x;

    function inc() external {
        x += 1;
    }
}

contract V2 {
    address public implementation;
    uint public x;

    function inc() external {
        x += 1;
    }
    function dec() external {
        x -= 1;
    }
}


