// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

// 多重委托调用合约 (只能调用自身)
contract MultiDelegatecall {
    error DelefatecallFailed();//自定义错误事件
    function multiDelegatecall(bytes[] calldata data) external payable returns (bytes[] memory results) {
        results = new bytes[](data.length); // 创建长度一样的 bytes 数组

        for(uint i; i < data.length; i++){
            //委托调用只能修改自身的数据状态
            (bool ok, bytes memory res) = address(this).delegatecall(data[i]);
            if(!ok){
                revert DelefatecallFailed();
            }
            results[i] = res;
        }
    }
}


// why use multi delegatecall? why not multi call?
// alice -> multi call ---call -> test(msg.sender = multi call)
// alice -> test ---  delegatecall -> test(msg.sender = alice)

// 我们写的测试合约   继承   多重委托调用合约
contract TestMultiDelegatecall is MultiDelegatecall {
    event Log (address caller, string func, uint i);

    function func1(uint x, uint y) external {
        emit Log(msg.sender, "func1", x+y);
    }
    function func2() external returns (uint) {
        emit Log(msg.sender, "func2", 2);
        return 111;
    }

    mapping(address => uint) public balanceOf;
    // 铸造方法，多重委托调用可能带来的漏洞 msg.value如果是1，执行这个函数3遍的话，  结果 1x3 = 3，但是我们只铸造了1的value
    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}

// 助手合约 获取data数据
contract Helper {
    // 生成二进制的func1 的bytecode data数据
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func1.selector, x, y);
    }
    // 生成二进制的func2 的bytecode data数据
    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.mint.selector);
    }

}