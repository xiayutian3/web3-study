// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract TimeLock {
    // 自定义报错
    error NotOwnerError(); //不是管理员
    error AlreadyQueuedError(bytes32 txId); //交易id已存在
    error TimestampNotInRangeError(uint blockTimestamp, uint timestamp); //超过时间范围
    error NotQueuedError(bytes32 txId); //交易不在队列中
    error TimestampNotPassedError(uint blockTimestamp,uint timestamp);//执行时间还没有到
    error TimestampExpiredError(uint blockTimestamp,uint expiresAt); //超过执行时间太久了
    error TxFailedError(); //执行失败事件

    event Queue(  //交易队列入队事件
        bytes32 indexed txId, //交易id
        address indexed target, 
        uint value, 
        string func, 
        bytes  data, 
        uint timestamp  
    );
    event Execute(  //执行成功事件
        bytes32 indexed txId, //交易id
        address indexed target, 
        uint value, 
        string func, 
        bytes  data, 
        uint timestamp  
    );
    event Cancel(bytes32 indexed txId); //取消交易事件


    uint public constant MIN_DELAY = 10; //最小的时间延迟  10s
    uint public constant MAX_DELAY = 1000; //最大的时间延迟  1000s
    uint public constant GRACE_PERIOD = 1000; //宽限期 1000s

    address public owner;
    mapping(bytes32 => bool) public queued; //记录交易id 映射


    constructor(){
        owner = msg.sender;
    }
    // 接收主币的回退函数
    receive() external payable {}

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
        // 获取交易id
        bytes32 txId = getTxId(_target, _value,_func,_data,_timestamp);
        // 交易是否在队列中
        if(queued[txId]){
            revert AlreadyQueuedError(txId);
        }
        // -----|-----------|---------------|-----
        //    block      block+min       block+max
        // 时间在 最小延迟 - 最大延迟之间，可以执行
         //超过最大最小值范围都不行
        if(
            _timestamp < block.timestamp + MIN_DELAY || 
            _timestamp > block.timestamp + MAX_DELAY
        ){
            revert TimestampNotInRangeError(block.timestamp, _timestamp);
        }

        // 把交易推入队列中
        queued[txId] = true;
        emit Queue(
           txId, _target, _value,_func,_data,_timestamp
        );
    }

    // 执行函数(执行的过程中可能会传送主币，所以payable)
    function execute(
        address _target, //要调用的合约地址
        uint _value, //发送的value，主币数量
        string calldata _func, //执行的函数的名称
        bytes calldata _data, //执行函数携带的数据
        uint _timestamp //执行的时间戳 
    ) external payable onlyOwner returns (bytes memory) {
        // 获取交易id
        bytes32 txId = getTxId(_target, _value,_func,_data,_timestamp);
        // 交易是否在队列中
        if(!queued[txId]){
            revert NotQueuedError(txId);
        }
        //触发时间还没有到
        if(block.timestamp < _timestamp){
            revert TimestampNotPassedError(block.timestamp, _timestamp);
        }

        // -----|-----------|---------
        // timestamp    timestamp + grace period(宽限期)
        // 执行时间超过宽限期就不能执行了
        if(block.timestamp > _timestamp + GRACE_PERIOD){
            revert TimestampExpiredError(block.timestamp, _timestamp + GRACE_PERIOD);
        }

        // 执行目标地址 call底层调用
        queued[txId] = false;

        bytes memory data;
        //如果是调用合约函数，对函数名，参数进行abi编码
        if(bytes(_func).length > 0){
            data = abi.encodePacked(
                bytes4(keccak256(bytes(_func))), _data
            );
        }else{
            //如果是调用合约的  回退函数
            data = _data;
        }

        (bool ok, bytes memory res) = _target.call{value: _value}(data);
        // 如果执行不成功
        if(!ok){
            revert TxFailedError();
        }
        // 触发执行成功事件
        emit Execute(txId, _target, _value, _func, _data, _timestamp);

        return res;
    }

    //取消交易事件（如果队列中的交易并不是一个合理的交易，或者不是正常的）
    function cancel(bytes32 _txId) external onlyOwner {
        //交易不存在
        if(!queued[_txId]){
            revert NotQueuedError(_txId);
        }
        //取消交易
        queued[_txId] = false;
        emit Cancel(_txId);
    }
}

contract TestTimeLock {
    address public timeLock; //时间锁合约地址
    constructor(address _timeLock) {
        timeLock = _timeLock;
    }

    function test() external view {
        require(msg.sender == timeLock,"not timelock");
    }
    //获取时间戳 + 100s
    function getTimestamp() external view returns (uint) {
        return block.timestamp + 100;
    }
}