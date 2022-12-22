// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7; 

contract AccessControl {

    // 对合约的修改一般都要触发事件
    event GrantRole(bytes32 indexed role, address indexed account); //升级事件
    event RevokeRole(bytes32 indexed role, address indexed account); //降级事件
    // 为什么不使用string 而用 bytes32，bytes32更节约gas费
    mapping(bytes32 => mapping(address => bool)) public roles;

    //定义常量 private 比public更节约gas
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    constructor(){
        _grantRole(ADMIN,msg.sender); //将admin的权限赋予合约的部署者
    }

    // 判断是不是管理的修改器
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender],"not authorized");
        _;
    }
    //升级函数（内部）
    function _grantRole(bytes32 _role,address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role,_account);
    }
     //升级函数（外部）
    function grantRole(bytes32 _role,address _account) external onlyRole(ADMIN) {
        _grantRole(_role,_account);
    }
    //降级函数
    function revokeRole(bytes32 _role,address _account) external onlyRole(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_role,_account);
    }




}