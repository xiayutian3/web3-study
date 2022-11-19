// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
pragma experimental ABIEncoderV2;   // 环境兼容,有些特性还不支持，所以加这个
// 多维数组

contract TestTwoArray {
    // [[],[],[]]

    //1.定长 2列 3行 
    uint[2][3] twoArrayFixed = [[2,23],[56,56],[45,89]];

    // 2.变长 -- push属性判断
    uint[][] twoArray;
    // new的方式创建变长二维数组
    uint[2][] grade = new uint[2][](0); //列的数字要确定，就是第一个【】要确定
    // uint[][3] grade2 = new uint[][3](0); //这钟方式不支持


    //获取定长二维数组
    function getTwoArrayFixed() public view returns(uint[2][3] memory){
        return twoArrayFixed;
    }
    //获取变长二维数组
    function getTwoArray() public view returns(uint[][] memory){
        return twoArray;
    }

    // 2.修改数组中的元素
    function changeelement() public {
        twoArrayFixed[0][1] = 78;
    }
    // 3.获取数组中的元素
    function getElement() public view returns(uint){
        return twoArrayFixed[0][1];  //0:行   1：列， 和上面初始化相反，
    }
    // function getElement2() public view returns(uint[] memory){
    //     return twoArrayFixed[0];
    // }
    // 4.获取二维数组的长度
    function getLength() public view returns(uint){
        return twoArrayFixed.length;
    }
    // 5.想二维数组中追加元素（变长，定长不可以）
    function pushTwoArray() public {
        twoArray.push([1,3]);
    }
    // 6.循环（双层循环）
    function searchArray() public view returns(uint) {
        uint sum = 0;
        for(uint i = 0;i<twoArrayFixed.length;i++){
            for(uint j = 0; j<twoArrayFixed[i].length;j++){
                sum+=twoArrayFixed[i][j];
            }
        }
        return sum;
    }

}