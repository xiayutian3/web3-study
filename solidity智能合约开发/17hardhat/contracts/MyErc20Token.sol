// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";


//abstract变成抽象合约后，可以不去实现IERC20合约中的函数
 contract MyErc20Token is IERC20Metadata {

    address private owner; //合约拥有者
    uint256 public totalSupply; //代币总数
    string public name = "BYD"; //货币名称
    string public symbol = "$"; //货币符号
    uint8 public decimals = 4;  //小数点的为数，小数点的精度,10的4次方， 一般是18
    mapping(address => uint) public balanceOf;  //账户余额映射
    mapping(address => mapping(address => uint)) public allowance; //授权使用的金额额度，授权者-》授予-》被授权者使用多少额度
    // // 自动生成的geter函数
    // function allowance(address owner, address spender) public view returns(uint){
    //     return allowance[owner][spender];
    // }

    constructor (uint _totalSupply) {
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
    }

    //判断是不是合约拥有者
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    //铸币方法，
    function mintTo(address to, uint amount) external isOwner {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    //铸币方法，投资人  链上募资
    function mintToByEther() external payable {
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
    }
    //当有人莫名其妙投钱的时候，也给他发送代币
    fallback() external payable {
       balanceOf[msg.sender] += msg.value;
       totalSupply += msg.value;
       emit Transfer(address(0), msg.sender, msg.value);
    }


    //转账操作(自己转出自己的钱)
    function transfer(address to, uint amount) external returns(bool) {
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
        return true;
    }

    // 审批
    function approve(address spender, uint amount) external returns (bool){
        // msg.sender资金拥有者，spender被审批人， amount审批的额度
        allowance[msg.sender][spender] = amount;
        return true;
    }
    // 转账（代理人转账操作）
    function transferFrom(
        address from,
        address to,
        uint amount
    ) external returns (bool){
        require(allowance[from][msg.sender] >= amount, "not allowed!");
        uint current = balanceOf[from];
        uint toc = balanceOf[to];
        current -= amount;
        toc += amount;
        balanceOf[from] = current;
        balanceOf[to] = toc;
        return true;
    }





    // 自毁合约，如果有余额，强制发送剩余主币 给 msg.sender， msg.sender默认没有payable属性
    function kill() external isOwner {
        selfdestruct(payable(msg.sender));
    }
}