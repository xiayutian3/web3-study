// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
contract TestGuanxi{
    function test() public pure returns(bool,uint,uint){
        // uint a = 3;
        // uint b = 4;
        // return (a++>b,a,b); //false 4 4

        uint a = 3;
        uint b = 3;
        return (a==b,a,b); //true 3 3
    }
}