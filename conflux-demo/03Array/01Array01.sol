// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 定长数组  不可以修改length  不能使用push
// 变长数组  不可以修改length  能使用push

contract Array01 {
    //声明
    
    uint[5] public fix; // 定长数组
    uint[] public ufix; // 变长数组  状态变量默认是storage

    // 声明并初始化
    uint[5] a = [1,2,3,4,5];
    uint[] b = [1,3,6];

    // 使用new的方式
    uint[] x = new uint[](4); //创建4的长度数组

    // 只有变长数组可以用push(storage 可以使用，memory不可以使用)
    function init() public {

        fix = [1,2,3,4,10];
        fix[0] = 15;

        ufix.push(10);
        ufix.push(12);

        //变长数组memory类型的，不能使用push
        // uint[] memory temp;
        // temp.push(4);

        // return fix;

    }


    // 获取定长数组
    function getFix() public view returns(uint[5] memory){
        return fix;
    }
    // 获取变长数组
    function getUFix() public view returns(uint[] memory){
        return ufix;
    }


}