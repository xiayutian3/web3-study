// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 我们猜想的代理合约

contract MyProxy {

    // 初始化，传入逻辑合约的地址，数据都在本合约上
    // immutable 不占用储存槽（slot）的位置，严格来讲，不是真的变量，是字面量，将值插入编译的代码中
    address immutable implementation;
    constructor(address addr){
      implementation = addr;
    }


    function _delegate(address _imp) internal virtual {
        assembly {
            // calldatacopy(t, f, s)
            // copy s bytes from calldata at position f to mem at position t
            calldatacopy(0, 0, calldatasize())
            // delegatecall(g, a, in, insize, out, outsize)
            // - call contract at address a
            // - with input mem[in…(in+insize))
            // - providing g gas
            // - and output area mem[out…(out+outsize))
            // - returning 0 on error and 1 on success
            let result := delegatecall(gas(), _imp, 0, calldatasize(), 0, 0)
            // returndatacopy(t, f, s)
            // copy s bytes from returndata at position f to mem at position t
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                // revert(p, s)
                // end execution, revert state changes, return data mem[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s)
                // end execution, return data mem[p…(p+s))
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(implementation);
    }
}
