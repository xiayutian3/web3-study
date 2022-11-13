// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

/*
    bytes（可变字节数组）  byte（定长字节数组） 里面都是字节的方式储存数据
    string UTF-8形式储存数据

    字符串的长度固定（长度可以确定的情况下），建议使用bytes32，代替string，消耗的gas，bytes32消耗的gas更少
*/

// 因为string在solidity里面是引用类型

// string类型表示汉字很直观
// string没有提供length和按索引访问的方式
contract testString{
    bytes9 sex = "女演员";

    function getSex() public view returns(bytes9){
        return sex;
    }

    bytes sex1 = "女演员";
    function getSex1() public view returns(bytes memory){
        return sex1;  //bytes: 0xe5a5b3e6bc94e59198
    }

    string sex2 = "女演员";
    function getSex2() public view returns(string memory){
        return sex2;
    }

    // 获取string length的方法转成bytes，在获取长度 ，一个中文占3个字节、
    function getLength() public view returns(uint){
        return bytes(sex2).length;  // 9  一个中文占3个字节
    }



    // string to bytes : bytes()
    // bytes to string : string()

    // byte（定长字节数组） to string  没有这类转换, 需要借助bytes才可以  byte -> bytes -> string
    function bytesToString() public view returns(string memory){
        return string(sex1);
    }
}