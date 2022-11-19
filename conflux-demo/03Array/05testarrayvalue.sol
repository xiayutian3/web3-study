// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 数组字面量

// 函数返回值是数组字面量，参数必须要指定长度,
// 参数的类型必须要明确说明要转换的类型
contract TestArrayValue {
    function arrayvalue() public pure returns(uint8[3] memory){
        return [1,2,3];
    }
    function arrayvalue2() public pure returns(int[3] memory){
        // 返回值 不一样的强制类型转换，成相同的类型
        return [int(1),2,3];
    }
}