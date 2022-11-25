// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// // 映射
// 1.关键字 mapping
// 2.存储一对数据，key-value
// 3.key 
//     能：uint int ... string address 
//     不能：动态数组，枚举，struct，mapping 
// 4. value的值基本无要求
// 5.mapping不能作为函数的参数使用（形参，返回值参数都不行）
// 6.mapping不能获取key值 （重要，与其他语言不同）
// 7.mapping是引用类型


contract TestMapping {
    mapping(uint=>string) public uintMapping;
    mapping(address=>uint) public addressMapping;
    mapping(string=>mapping(uint=>address)) public stringMapping;
    constructor() public {
        uintMapping[1] = "hello";
        uintMapping[2] = "hui";

        addressMapping[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = 1;
        addressMapping[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 2;

        stringMapping["heel"][1] = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    }

    // // mapping 的 getter函数 ，0.6.0以后已经不能重写了 
    // function uintMapping1(uint _u) public view returns(string memory){
    //     return uintMapping[_u];
    // }

    // function stringMapping1(string memory _s,uint _u) public view returns(address){
    //     return stringMapping[_s][_u];
    // }
}