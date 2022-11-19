// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

contract TestGlobal{

    // 所有的全局变量获取 都有 view 函数

    // blockhash(uint blockNumber) returns (bytes32)：指定区块的区块哈希 —— 仅可用于最新的 256 个区块且不包括当前区块，否则返回 0 
    // block.number ( uint ): 当前区块号 区块的高度
    //获取上一个区块哈希
    function getBlockHash() public view returns(bytes32){
        return blockhash(block.number - 1);
    }

    // 获取当前旷工的地址
    function getCoinbase() public view returns(address){
        return block.coinbase;
    }

    // 获取当前区块的难度
    function getDifficulty() public view returns(uint){
        return block.difficulty;
    }
    // 获取当前调用发起人的地址
    function getSender() public view returns(address){
        return msg.sender;
    }


}