// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
contract TestTypechange{
    // int8->int256 隐式转换
    function autoType() public pure returns(int){
        int8 a = 3;
        int c = a;
        return c;
    }

    //强制类型转换
     function typeChange() public pure returns(uint8){
        int8 a = -3;
        uint8 c = uint8(a);  //无法转化，或者转换结果不对，因为uint 是正整数
        return c;
    }

    //强制类型转换
    function typeChange2() public pure returns(bytes2){
        uint32 a = 0x12345678;
        uint16 c = uint16(a);   //无法转化 32 转不了 16，转出的结果不正确（//高位截断 ），只能16转32 ,
        bytes2 d = bytes2(c);   //查看 32->16的结果
        return d;
    }


}