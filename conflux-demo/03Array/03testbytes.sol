// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
// 类型为bytes和字符串的变量是特殊数组。bytes类似于byte[]，但它在calldata中被紧密地打包。
// bytes（可变字节数组）应该优先使用，因为更便宜。

contract TestBytes{
    //节省空间
    bytes bs; //16进制
    bytes bs0 = "12abcd";
    bytes bs1 = "abc\x22\x22"; //16进制
    bytes bs2 = "tiny\u718A"; // 718A 汉字 "熊" Unicode 编码值 汉字占3个字节

    function testBytes0() public view returns(bytes memory){
        return bs;
    }
    function testBytes1() public view returns(bytes memory){
        return bs0;
    }
    function testBytes2() public view returns(bytes memory){
        return bs1;
    }
    function testBytes3() public view returns(bytes memory){
        return bs2;
    }


    // 获取长度
    function getLength() public view returns(uint){
        return bs0.length;  //6
    }
    // 改变元素
    function changeElement() public {
        bs0[0] = 0x45; //0x313261626364 -> 0x453261626364
    }
    // 添加元素
    function pushName() public {
        bs0.push(0x23);
    }


    //定长字节数组如何 转 变长字节数组
    bytes6 by = 0x121345565254;
    function fixedToDynamic() public view returns(bytes memory){
        bytes memory temp = new bytes(by.length);
        for(uint i=0;i<by.length;i++){
            temp[i] = by[i];
        }
        return temp;
    }
}