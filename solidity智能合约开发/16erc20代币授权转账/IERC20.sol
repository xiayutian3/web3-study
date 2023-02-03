// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// interface中的方法全部都是 external的
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value); //许可，授权权限

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    // 被允许的
    function allowance(address owner, address spender) external view returns (uint);

    // 审核，审批
    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
}