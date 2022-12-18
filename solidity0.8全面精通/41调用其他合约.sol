// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract CallTestContract {
    function setX(TestContract _test, uint _x) external {
        _test.setX(_x);
    }
    function getX(address _test) external view returns (uint x){
        x = TestContract(_test).getX();
    }
    function setXandSendEther(address _test, uint _x) external payable {
        TestContract(_test).setandReceiveEther{value:msg.value}(_x);
    }
    function getXandValue(address _test) external view returns(uint x, uint value){
        (x,value) = TestContract(_test).getXandValue();
    }
}


contract TestContract {
    uint public x;
    uint public value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint){
        return x;
    }
    function setandReceiveEther(uint _x) external payable{
        x = _x;
        value = msg.value;
    }
    function getXandValue() external view returns (uint, uint){
        return (x,value);
    }

}