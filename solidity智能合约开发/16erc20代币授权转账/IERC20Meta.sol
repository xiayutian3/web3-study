// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// interface中的方法全部都是 external的
interface IERC20Metadata {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}