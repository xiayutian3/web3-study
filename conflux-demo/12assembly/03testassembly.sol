// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 八、solidity 流程控制语句

contract TestAssembly {
    function testIf(uint n ) public pure returns(bool flag){
        assembly {
            flag := true
            if lt(n,5) {  // 如果n<5
                flag := false
            }
        }
    }

    function testSwitch( uint n) public pure returns(uint x){
        assembly {
            let z := n
            // let x
            switch z
                case 1{
                    x := 1
                }
                case 2{
                    x := 2
                }
                default{
                    x := 15
                }
        }
    }


    function testFor()public pure {
        assembly {
            
            for{let x:= 0} lt(x,5) {x := add(x,1)}{ // 赋值语句  条件语句  判断语句

            }
        }
    }
}