// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// solidity数据储存位置

// storage：区块链上（重要数据才存放在这里）
            // 什么样的数据类型可以使用storage：数组、结构体、映射（引用数据类型）
            // 0.5.0以后的版本，强制要求制定memory或storage
// memory： 内存中
// 栈 ：值类型的局部变量储存在此
// calldata：当函数为外部函数（external），如果此函数，有参数（非返回参数），则参数必须使用calldata修饰

contract TestMemoryAndStorage {
    // 当函数为外部函数（external），如果此函数，有参数（非返回参数），则参数必须使用calldata修饰
    //calldata
    function testCalldata(uint[] calldata m) external { //外部函数

    }

    // 值传递 还是 引用传递
    uint[] a1 = [1,2,4];  //storage  状态变量


    // 1.storage -> memory  值传递
    function storageToMemory() public view {
        uint[] memory b = a1;  // 值传递，a1没有变化
        b[0] = 100;
    }
    function getA1() public view returns(uint[] memory ){
        return a1;
    }
    // 2.memory -> storage //值传递
    function memoryToStorage() public {
        uint8[3] memory c = [10,12,13];
         a1 = c; //值传递 状态数据a1变成了[10,12,13]
        c[1] = 52; //但是 修改c的时候，a1没有发生变化还是[10,12,13]，所以说是值传递
    }
    // 3.storage -> storage  引用传递
    function storageToStorage() public {
        uint[] storage m = a1; //引用传递,a1的值变了
        m[2] = 50;
    }
    // 4.memory -> memory  引用传递
    function memoryToMemory() public pure returns(uint8[3] memory) {
        uint8[3] memory a = [1,2,3];
        uint8[3] memory b = a; //引用传递,a的值变了
        b[1] = 50;
        return a;
    }
}