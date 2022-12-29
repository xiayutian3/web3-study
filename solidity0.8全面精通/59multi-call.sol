// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

// multi call 是把对一个或多个合约的多次调用，整合成一个调用，以太坊链rpc节点对调用有限制（20s内1次）

contract TestMultiCall {
    function func1() external view returns (uint, uint) {
        return (1, block.timestamp);
    }
    function func2() external view returns (uint, uint) {
        return (2, block.timestamp);
    }

    // 获取函数签名
    function getData1() external pure returns (bytes memory) {
        // abi.encodeWithSignature("func1()") //和下面的写法是等价的
        return abi.encodeWithSelector(this.func1.selector);
    }
    function getData2() external pure returns (bytes memory) {
        // abi.encodeWithSignature("func2()") //和下面的写法是等价的
        return abi.encodeWithSelector(this.func2.selector);
    }
}

// 多重呼叫
contract MultiCall {
    // address 目标合约的地址数组， data 目标合约的函数签名数组（也包含函数的参数）
    function multiCall(address[] calldata targets, bytes[] calldata data) external view returns (bytes[] memory){
        require(targets.length == data.length, "targets length != data length");
        bytes[] memory results = new bytes[](data.length);

        for(uint i; i<targets.length; i++) {
            (bool success, bytes memory result) = targets[i].staticcall(data[i]); // view  静态调用：staticcall  ，不能用call（动态写入调用）
            require(success, "call failed");
            results[i] = result;
        }
        return results;
    }
}