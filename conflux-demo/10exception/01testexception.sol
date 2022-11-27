// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// solodity异常
// 1.程序编译或运行中发生的错误即异常
// 2.发生运行时异常，会将之前修改的状态全部还原（0.6.0+的版本，可以选择）
// 3.solidity异常
//     3.1）0.4.10之前，throw 条件不满足，中断运行，恢复修改的状态，耗光gas
//     3.2）0.4.10之后，throw废弃，require（）、 assert（） 、revert（）--代替原来的throw
//     3.3）0.6.0+的版本，try...catch...
// 4.功能介绍
//     4.1条件检查
//         require: 还原状态  退回剩余gas  oxfd
//         assert：还原状态  耗光gas   oxfe（throw）
//     4.2引发异常
//         throw：废弃，使用：throw
//         revert() 还原状态：与throw区别
//             a.允许返回错误原因
//             b.退回剩余gas
//     4.3捕获/处理异常
//         try...catch ...
//         a.只合适于外部调用
//         b.如何使用调用的函数的返回值
//         c.多个catch，如何写
//              catch Error(string memory){}: require(条件，“错误信息”),revert(“错误信息”)
//              catch(bytes memory): assert()， require(条件),revert()




contract TestException{
    uint public data = 100;


    //require，，条件不满足，回退之前的状态，返回剩余gas
    function testRequire(uint i) public {
        data = 200;
        require(i>10,"错误原因"); //也可以不写错误原因
    }
    // assert，条件不满足，回退之前的状态， 耗光gas
    function testAssert(uint i) public {
        data = 200;
        assert(i>10);
    }

    //  revert 引发异常 还原状态  退回剩余gas
    function testRevert(uint i) public returns(uint) {
        data = 200;
        if(i<10){
            //也可以不写错误原因
            revert("错误原因");
        }

        //假设返回值
        return 23;
    }


    // trycatch捕获异常，出错还原异常
    event sucessEvent();
    event failEvent();
    function testTry(uint i) public {
        // 外部调用 testRevert 方法
        try this.testRevert(i){
            emit sucessEvent();
        }catch{
            emit failEvent();
        }
    }

    // 获取 testRevert 返回值 
    function testTry2(uint i) public returns(uint){
        // 外部调用 testRevert 方法
        try this.testRevert(i) returns(uint v){
            emit sucessEvent();
            return v;
        }catch{
            emit failEvent();
        }
    }




    // 案例三 分别捕获错误

    function testError(uint i,uint u) public {
        data =200;
        require(i<30,"require错误信息"); //要写上错误信息，不然都被认为是 assert 的错误
        assert(u<10);
       
    }
    //两种类型的异常事件
    event requireEvent();
    event assertEvent();

    function testCatch(uint i,uint u) public {
        try this.testError(i,u){
            emit sucessEvent();
        }catch Error(string memory){//捕获 require(),revert()
            emit requireEvent();
        }catch(bytes memory){ //捕获 assert()
            emit assertEvent();
        }
    }

}