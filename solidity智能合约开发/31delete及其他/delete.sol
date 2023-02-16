// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// // delete解析
// 1.delete对于固定长度的数据类型将其置为默认值，对于动态数据类型，将其长度置为0，其实相当于重新初始化
// 2.对于memory和storage的操作语义是一样的
//     1对数组：静态数组，delete之后的数组长度不变，元素置为默认值；动态数组，delete之后长度变为0
//     2delete数组元素，该元素置为默认值，长度不变
//     3对mapping整体不起作用，对struct中的mapping也不起作用；但是可以delete某一entry  例如：delete data[8]
//     4不能delete storage reference局部变量，就是不能delete成员变量的引用，要直接delete成员变量


contract DeleteTest {
    uint[] public data;

    // mapping只能定义在storage中，不能定义在局部变量中
    mapping(uint => uint) public mymap;

    // 静态数组
    function testDelete() public pure returns(uint[3] memory) {
        uint[3] memory x = [uint(1), uint(2),uint(3)];
        delete x;
        return x;
    }
    // 动态数组
    function testDelete2() public pure returns(uint[] memory) {
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 1;
        x[2] = 1;
        delete x;
        return x;
    }
    // 测试mapping
    function testMapping() external {
        mymap[1] = 25;
    }
    function testMappingDelete() external {
        delete mymap[1];
    }

    // 测试delete storage reference局部变量 
    function testRefDelete() external {
        uint[] storage pdata = data; //指针指向data
        // delete pdata; //直接报错
    }


    // 测试结构体
    struct MyStruct {
        string name;
        uint value;
    }
    function testStruct() external pure returns(MyStruct memory){
        MyStruct memory rst = MyStruct("hello", 100);
        return rst;
    }
    function testStructDelete() external pure returns(MyStruct memory){
        MyStruct memory rst = MyStruct("hello", 100);
        delete rst;
        return rst;
    }
    function testStructDeleteMember() external pure returns(MyStruct memory){
        MyStruct memory rst = MyStruct("hello", 100);
        delete rst.name;
        return rst;
    }


}