// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

// ICO 融资
// ERC20 规范 
// goerli 测试网  合约地址 0x310d53CDe701D6536707a69Bd3937BF08F3025B9

contract MyErc20Token {
    event TransferEvent(uint oldv, uint newv);//转账事件

    uint total = 10*8; //一共发行的代币总量
    uint current = 0;  //当前发行的代币总量
    address private owner; //合约拥有者
    string public name = "BYD"; //货币名称
    string public symbol = "$"; //货币符号
    uint public decimals = 4;  //小数点的为数，小数点的精度,10的4次方， 一般是18

    mapping(address => uint) public balanceOf;  //账户余额映射
    // function balanceOf(address key) public view returns(uint){ //get函数
    //     return balanceOf[key];
    // }
    address[] holders;//代币持有者数组，用来对应mapping的数据，因为mapping不能遍历


  // 已经有铸币函数了，初始化就不需要直接生成代币了
    // constructor (uint total) {
    //     balanceOf[msg.sender] = total;
    // }
    constructor () {
        owner = msg.sender;
    }

    //判断是不是合约拥有者
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    // 添加代币持有者
    function add(address holder) internal {
        holders.push(holder);
    }

    // 删除某个下标，代币持有者
    function remove(address holder) internal {
        uint index = 0;
        for(uint i=0; i<holders.length; i++){
            if(holder == holders[i]){
                index = i;
            }
        }
        address l = holders[holders.length];
        holders[index] = l;
        holders.pop();
    }

    // // 分红的时候(按照投资人的比例，分红)，这里只是简单说明下，不作具体实现
    // function divident() public view {
    //     for(uint i=0; i<holders.length; i++){
    //         uint balance = balanceOf[holders[i]];
    //     }
    // }


    //铸币方法，将外部合约发送过来的以太币，以1:1的形式，铸造代币， 单位对应wei
    function mint() public payable {
        //如果铸币超过发行的总量，就不允许再铸币了，把钱退还给投资者
        // if(current + msg.value > total){
        //     msg.sender.call{value: msg.value}("");
        // }

        // 或者直接使用require判断，不满足条件，钱也过不来
        require(current + msg.value <= total, "too much");
        balanceOf[msg.sender] += msg.value;
        add(msg.sender);//添加到代币持有者数组中
    }

    //提款
    function withdaw() public isOwner {
        // 获取合约当前余额
        uint bal = address(this).balance;
        // 用call来转账，不管转账访方是外部合约，还是内部合约，都能确保转账的正产执行
        msg.sender.call{value: bal}("");
    }

    //转账操作
    function transfer(address to, uint amount) public {
        address from = msg.sender;
        uint current = balanceOf[from];
        if(current <= amount){
            revert("not enough balanceOf");
        }
        uint toc = balanceOf[to];

        current -= amount;
        toc += amount;
        balanceOf[from] = current;
        balanceOf[to] = toc;
    }

    // 由于某种原因，用户直接给合约转账，我们也应该让用户拥有相应的代币数量，可以使用fallback，receive
    // 用于 address。call{value:xx}(),触发。addresss.send() ,addresss.transfer()不能触发
    fallback() external payable {
        mint();
    }
    // 适用于 addresss.send() ,addresss.transfer()
    // 但是 send，transfer有gas的限制 2300，只能做的操作 如发送日志，emit eventxx，执行不了mint()函数的逻辑，所以没什么太大的作用，写receive没什么意义
    // 如果单纯写receive函数，里面没有任何逻辑的话，确实可以实现转账。但是用户什么也没得到，就属于诈骗合约了，所以宁可让用户转账失败，也不扣了用户的钱，缺什么也没做
    // receive() external payable {
    //     // 2300 gas不足以支持下面的函数操做 
    //     mint(); 
    // }
    

    // 获取当前合约余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }


    // 自毁合约，如果有余额，强制发送剩余主币 给 msg.sender， msg.sender默认没有payable属性
    function kill() external isOwner {
        selfdestruct(payable(msg.sender));
    }
}