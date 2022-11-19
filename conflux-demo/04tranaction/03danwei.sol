// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestDanwei {
    // 时间类型 都为 uint  solidity会把时间都变成秒
    uint public lastUpdated;
    function setLastUpdate() public{
        lastUpdated = now; //设置为当前时间
    }
    function fiveM() public view returns(bool){
        if(now >= lastUpdated + 10 seconds){  //算数运算优先级大于 关系运算优先级
            return true;
        }else{
            return false;
        }
    }
}