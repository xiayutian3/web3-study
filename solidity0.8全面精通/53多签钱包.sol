// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

contract MultiSigWallet {
   
    event Deposit(address indexed sender,uint amount);  //存款
    event Submit(uint indexed txId); //提交
    event Approve(address indexed owner, uint indexed txId); //审批
    event Revoke(address indexed owner, uint indexed txId); //撤回审批
    event Execute(uint indexed txId);  //执行

    // 交易数据格式
    struct Transaction {
        address to; //交易的目标地址
        uint value; //交易的数量金额
        bytes data;  //交易的data数据 ,如果交易的地址是合约的话，可能会调用合约中的函数
        bool executed; //是否已经执行过这笔交易
    }

    address[] public owners; //签名人数组
    mapping(address => bool) public isOwner; //用来判断某个用户是不是签名人地址，数组的效率太低了，所以用映射
    uint public required; //最少的签名数

    Transaction[] public transactions;
    //每个交易下对应的批准人的批准情况 (交易数组下标 - 地址 - 是否批准)
    mapping(uint => mapping(address => bool)) public approved;

    // 判断是不是签名人
    modifier onlyOwner(){
        require(isOwner[msg.sender],"not owner");
        _;
    }
    // 判断交易是否存在
    modifier txExists(uint _txId){
        require(_txId < transactions.length,"tx does not exist");
        _;
    }
    // 交易是否被批准过
    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender],"tx already approved");
        _;
    }
    // 交易是否执行过
    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed,"tx already executed");
        _;
    }

    // 初始化 签名人数组 ，确认数
    constructor(address[] memory _owners,uint _required){
        require(_owners.length > 0, "owners required");
        require(_required>0 && _required <= _owners.length,"invalid required number of owners");
        for(uint i = 0; i<_owners.length;i++){
            address owner = _owners[i];
            require(owner != address(0),"invalid owner");
            require(!isOwner[owner],"owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    // 接受主币的方法
    receive() external payable {
        // 触发接受事件
        emit Deposit(msg.sender,msg.value);
    }


    function submit (address _to, uint _value, bytes calldata _data) external onlyOwner{
        // 将交易推入交易数组
        transactions.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            executed:false
        }));
        emit Submit(transactions.length - 1);
    }

    // 批准
    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId){
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender,_txId);
    }

    // 获取某个交易的批准的人数
    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for(uint i; i<owners.length;i++){
            if(approved[_txId][owners[i]]){
                count += 1;
            }
        }
    }

    // 执行交易
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId){
        require(_getApprovalCount(_txId) >= required,"approvals < required");
        Transaction storage transaction = transactions[_txId];

        transaction.executed = true;
        //发送主币 低级call的方式
        (bool success,) = transaction.to.call{value:transaction.value}(transaction.data);
        require(success,"tx failed");
        emit Execute(_txId);

    }

    // 审批撤销事件
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender],"tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);
    }

}