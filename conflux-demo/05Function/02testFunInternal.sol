// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0;

// 函数可见性
//     internal：状态变量、函数     (只允许内部调用，不允许外部调用)  能继承
//     external 函数     (只允许外部调用)
//     public：状态变量、函数     (只允许内部、外部调用)
//     private：状态变量、函数    (只允许内部调用，不允许外部调用)  不能继承
contract TestFunInternal{

    function testInternal() internal pure returns(uint){
        return 10;
    }
    function testExternal() external pure returns(uint){
        return 20;
    }
    function testPublic() public pure returns(uint){
        return 30;
    }
    function testPrivate() private pure returns(uint){
        return 40;
    }

    function test() public pure returns(uint){
        // return testInternal();  //yes  内部调用方式
        // return this.testInternal(); //no 外部调用方式

        // return testExternal();  //no
        // return this.testExternal();  //yes

        // return testPublic();   // yes 用pure来修饰即可
        // return this.testPublic();  //yes  this的访问形式，用view来修饰，因为他觉得你访问了状态变量

        return testPrivate();  //yes
        // return this.testPrivate();  //no

    }
}

// 另外一个合约

contract Test {
    function test2() public returns(uint){
        //实例化合约
        TestFunInternal tf = new TestFunInternal();
        // return tf.testInternal(); // 外部调用方式
        return tf.testExternal(); 
    }
}