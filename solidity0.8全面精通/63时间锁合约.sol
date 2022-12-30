// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract TimeLock {
    // 自定义报错
    error NotOwnerError(); //不是管理员
    error AlreadyQueuedError(bytes32 txId); //交易id已存在

    address public owner;
    mapping(bytes32 => bool) public queued; //记录交易id 映射


    constructor(){
        owner = msg.sender;
    }
    //修改器 ：判断是不是管理员
    modifier onlyOwner() {
        if(msg.sender != owner) {
            revert NotOwnerError();
        }
        _;
    }
    // 创建交易id函数
    function getTxId(
        address _target, //要调用的合约地址
        uint _value, //发送的value，主币数量
        string calldata _func, //执行的函数的名称
        bytes calldata _data, //执行函数携带的数据
        uint _timestamp //执行的时间戳 
    ) public pure returns (bytes32 txId) {
        return keccak256(
            abi.encode(
                _target, _value,_func,_data,_timestamp
            )
        );
    }

    // 队列函数
    function queue(
        address _target, //要调用的合约地址
        uint _value, //发送的value，主币数量
        string calldata _func, //执行的函数的名称
        bytes calldata _data, //执行函数携带的数据
        uint _timestamp //执行的时间戳 
    ) external onlyOwner {
        bytes32 txId = getTxId(_target, _value,_func,_data,_timestamp);
        if(queued[txId]){
            revert AlreadyQueuedError(txId);
        }
    }

    // 执行函数
    function execute() external {
        
    }
}

contract TestTimeLock {
    address public timeLock; //时间锁合约地址
    constructor(address _timeLock) {
        timeLock = _timeLock;
    }
    function test() external {
        require(msg.sender == timeLock);
    }
}