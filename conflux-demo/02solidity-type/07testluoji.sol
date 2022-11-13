// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
contract TestLuoji{
    function test(uint a,uint b) public pure returns(bool,uint,uint){
        bool c = (++a<b++)&&(++a>++b);
        return (c,a,b);  // false 4 5
    }
}