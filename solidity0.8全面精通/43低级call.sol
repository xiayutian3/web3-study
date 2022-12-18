// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

//测试合约（被调用）
contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint _x) external payable returns(bool,uint){
        message = _message;
        x = _x;
        return (true, 999);
    }
}

// 调用合约
contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        // 以低级call的方式  abi编码   调用合约方法 
        // 函数签名： "foo(string,uint256)",  参数一："call foo", 参数二：123
        // 返回值两个：第一个bool，第二个bytes memory data
        // call{value: 111, gas: 5000 } 发送的主币 111 wei  携带5000个gas ,5000gas修改两个状态变量不够
        // call{value: 111 }
        (bool sucess, bytes memory _data) = _test.call{value: 111 }(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123));
        require( sucess,"call failed");
        data = _data;
    }

    // 调用对方合约不存在的函数，触发fallback方法
    function callDoesNotExit(address _test) external {
        (bool sucess,) = _test.call(abi.encodeWithSignature("doesNotExit()"));
        require(sucess,"call failed");
    }
}
