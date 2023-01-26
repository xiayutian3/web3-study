// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface ProxyInterface {
    function inc() external;

    function x() external view returns (uint256);
}

contract Proxy {

  // 将非业务数据放到很远的地方，不占合约插槽，所有的数据状态变量放在相应的升级合约当中，升级的合约就不需要考虑数据插槽的位置了
    bytes32 private constant implementationPosition =
        keccak256("org.zeppelinos.proxy.implementation");

    function upgradeTo(address newImplementation) public {
        address currentImplementation = implementation();
        setImplementation(newImplementation);
    }

    function implementation() public view returns (address impl) {
        bytes32 position = implementationPosition;
        assembly {
            impl := sload(position)
        }
    }

    function setImplementation(address newImplementation) internal {
        bytes32 position = implementationPosition;
        assembly {
            sstore(position, newImplementation)
        }
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

    // fallback本身没有返回值，所以使用汇编将返回值返回出来
    fallback() external payable {
        _delegate(implementation());
    }
}

contract V1 {
    uint256 public x;

    function inc() external {
        x += 1;
    }
}

contract V2 {
    uint256 public x;

    function inc() external {
        x += 1;
    }

    function dec() external {
        x -= 1;
    }
}
