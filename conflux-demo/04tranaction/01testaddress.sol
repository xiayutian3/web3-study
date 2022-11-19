// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestAddress {
    // 合约地址 20字节 160位  uint160 可以表示
    function TestAddress1()public pure returns(uint160) {
        address _address = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        return uint160(_address);

    }
}