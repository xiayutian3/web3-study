// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestBreak{
    // break 中断所有循环
    function testBreak()public pure returns(int){
        int sum = 0;
        for(int i=0;i<10;i++){
            if(i == 3){
                break;
            }
            sum += i;
        }
        return sum; // 3
    }

     // continue 中断本次循环，继续后面的循环
    function testContinue()public pure returns(int){
        int sum = 0;
        for(int i=0;i<10;i++){
            if(i == 3){
                continue;
            }
            sum += i;
        }
        return sum; //42
    }

}