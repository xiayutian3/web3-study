// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 0.8.0+后发生了重大变化
// require：当第一个参数为false是，执行revert， revert和require可以说是一样的
// assert revert：历史上曾经不一样，现在一样了

contract ErrorHandle {
    function testRevert() public {
        revert("kkk");
    }
    function testAssert() public {
        assert(1 == 2);
    }

    // 系统级别的错误，当y为0时，
    function testPanic(uint x, uint y) public {
        uint z = x/y;
    }
}