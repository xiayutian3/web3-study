// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 库的作用
//     1.代码的重用性
//     2.可以节省gas
// 关键字 ：library
// 其他特性
// 1.库中的函数不能修改状态变量
// 2.库不可以被销毁
// 3.不能定义状态变量
// 4.不可以继承任何其他元素
// 5.库也不能被继承
// 6.库也不能接受 以太币


library Search {
    function indexof(uint[] storage data, uint _value) public view returns(uint){
        for(uint i=0;i<data.length;i++){
            if(data[i] == _value){
                return i;
            }
        }
        return uint(-1);
    }
}



// 案例：设有一个数组，根据传进来的值，找到数组所在的下标

contract TestLibrary{
    uint[] data;
    constructor() public {
        data.push(1);
        data.push(2);
        data.push(3);
    }
    // function indexof(uint _value) public view returns(uint){
    //     for(uint i=0;i<data.length;i++){
    //         if(data[i] == _value){
    //             return i;
    //         }
    //     }
    //     return uint(-1);
    // }

    // 使用库后
    function indexof(uint _value) public view returns(uint){
        return Search.indexof(data,_value);
    }
}