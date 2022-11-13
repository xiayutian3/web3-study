// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
// 循环体
contract TestFor {
    // for
    function testFor() public pure returns(int) {
        int sum = 0;
        for(int i = 0; i<10 ; i++){
            sum+=i;

        }
        return sum;
    }

    // while
    function testWhile() public pure returns(int,int) {
        int sum = 0;
        int x = 10;
        while(x<20){
            sum+=x;
            x++;
        }
        
        return (sum,x);
    }

    // do ... while
    function testDoWhile(int x) public pure returns(int) {
        int sum = 0;
        do{
            x++;
            sum+=x;
        } while (x<20);
        
        return sum;
    }
}