// // version
// // SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0;

// contract HelloWorld {
//     //状态存在合约上，状态变量
//     string name = "hello";
    
//     // public view 函数的修饰符，view 读取了状态变量，不能修改，不会消耗任何资源
//     function getName() public view returns(string memory){
//         return name;
//     }
//     // public pure 函数的修饰符， pure 既没有读取状态变量，也没有修改，普通的函数，不会消耗任何资源
//     function f() public pure returns(string memory){
//         return 'world';
//     }
//     // public 函数的修饰符，读取了状态变量，也修改了状态变量，会消耗任何资源
//     function setName() public {
//         name = "hello2";
//     }
// }


// *******合约的整体结构*******

// // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
// import "./demo.sol"

contract boolDemo {
    // 状态变量
    uint public level = 0;

    // 函数
    function equal() public pure returns(bool){
        uint a = 10;
        uint b = 20;
        return a == b; // false
    }

    // 函数修饰器
    modifier levelRequires(uint _level){
        require(level > _level);
        _;
    }
    
    // 事件
    event high(address bidder, uint amount); // 定义事件
    // 触发事件
    function bid() public payable{
        //....
        emit high(msg.sender,msg.value); //触发事件
    }
    // 结构体
    struct Student{
        uint age;
        string name;
    }
    // 枚举类型
    enum State {
        Locked,
        Inactive
    }
}

