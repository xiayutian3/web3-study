// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

// library的运行机制
// 1.当library含有public可见性的函数的时候，这个library要部署为单独的合约
// 2.在完整的合约部署时，要通过linkref，将library合约地址交给使用它的合约，将两个合约连接起来

// demo1
library Math {
    function max(uint x, uint y) internal pure returns(uint){
        return x >= y ? x: y;
    }
}

contract Test {
    function testMax(uint x, uint y) external pure returns(uint){
        return Math.max(x,y);
    }
}



// demo2
library ArrayLib {
    // arr 因为传入状态变量，所以用storage，读取了状态变量，所以用view
    function find(uint[] storage arr, uint x) internal view returns(uint){
        for(uint i = 0; i<arr.length; i++){
            if(arr[i] == x){
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    //将库合约设置为某个类型，这样这个类型的数据就可以直接调用，该库合约上的方法了
    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    function testFind() external view returns(uint i){
        // return ArrayLib.find(arr,2);
        return arr.find(2);
    }
}