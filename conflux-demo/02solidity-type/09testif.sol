// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
// if 条件判断
contract TestIf {
    function testIf(uint a) public pure returns (string memory ){
        if(a>10 && a<=20){
            return "a大于10，并且小于20";
        }
    }
}