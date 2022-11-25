// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 创建合约的方式
    // 1.new
    // 2.外部方式（js-sdk，java-sdk，python-sdk），（abi文件，bytecode文件，执行创建）

contract TestNewContract {
    uint public age = 0;  // 不建议在状态变量上 用public修饰， 因为其他合约在外部可以访问，或修改，主要是不安全
    function getName() public pure returns(string memory){
        return "hello";
    }
}

contract Test {
    TestNewContract tc;

    function testNewContract() public returns(TestNewContract){
        tc = new TestNewContract(); // 创建合约，返回合约的地址
        return tc;
    }

    //调用合约的方法
    function getTcName() public view returns(string memory){
        return tc.getName();
    }
    
    //访问属性
    function getAge() public view returns(uint){
        return tc.age();  //因为属性加了public 会自动生成 getter函数
    }
}
