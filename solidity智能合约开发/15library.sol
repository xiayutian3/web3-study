// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// library的运行机制
// 1.当library含有public可见性的函数的时候，这个library要部署为单独的合约
// 2.在完整的合约部署时，要通过linkref，将library合约地址交给使用它的合约，将两个合约连接起来

library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "uint overflow");
        return z;
    }
}

library Math {
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

// 操作 mapping 状态数据 的库合约,修改调用者的状态
library BalanceOperator {
    function setBalance(
        mapping(address => uint256) storage balanceof,
        address addr
    ) internal {
        balanceof[addr] = 100;
    }
}

contract TestSafeMath {
    mapping(address => uint256) balanceOf;
    // using SafeMath for uint;
    using Math for uint256;
    uint256 public MAX_UINT = 2**256 - 1;

    function testAdd(uint256 x, uint256 y) public pure returns (uint256) {
        return SafeMath.add(x, y);
    }

    function testSquareRoot(uint256 x) public pure returns (uint256) {
        return x.sqrt();
    }
}

// Array function to delete element at index and re-organize the array
// so that their are no gaps between the elements.
library Array {
    function remove(uint256[] storage arr, uint256 index) public {
        // Move the last element into the place to delete
        require(arr.length > 0, "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArray {
    // using Array for uint[];
    uint256[] public arr;

    function testArrayRemove() public {
        for (uint256 i = 0; i < 3; i++) {
            arr.push(i);
        }
        Array.remove(arr, 1);
        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }

    function getLibArrayAddress() public view returns (address) {
        return address(Array);
    }

    function getLibMathAddress() public view returns (address) {
        return address(Math);
    }
}
