// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//模拟  MinimalProxyContract.sol  合约

contract MyProxySimplified {


    fallback() external payable {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
