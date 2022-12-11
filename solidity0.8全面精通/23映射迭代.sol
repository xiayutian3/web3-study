// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract IterableMapping {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    // 设置 mapping 和数组
    function set(address _key, uint _val) external {
        balances[_key] = _val;
        if(!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }
    // 获取长度
    function getSize() external view returns (uint){
        return keys.length;

    }

    // 返回第一个
    function first() external view returns(uint){
        return balances[keys[0]];
    }
    // 返回最后一个
    function last() external view returns(uint){
        return balances[keys[keys.length - 1]];
    }
    //返回任意一个索引
    function get(uint _i) external view returns(uint){
        return balances[keys[_i]];
    }

}