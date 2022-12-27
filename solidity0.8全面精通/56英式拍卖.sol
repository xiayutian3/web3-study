// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

// IERC721接口
interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract EnglishAuction {
    event Start(); //开始事件
    event Bid(address indexed sender, uint amount);    //拍卖事件
    event Withdraw(address indexed bidder, uint amount); //取款事件 竞拍者  竞拍的钱
    event End(address highestBidder, uint amount); //结束事件

    IERC721 public immutable nft; //nft合约
    uint public immutable nftId; //nft合约中的某个nft

    // 针对拍卖者
    address payable public immutable seller; //出售者
    uint32 public endAt; //结束时间
    bool public started; //是否开始
    bool public ended; //是否结束

    // 针对购买者
    address public highestBidder; //最高出价者
    uint public highestBid; //最高的出价
    mapping(address => uint) public bids; //每次最高出价者的出价记录,方便退款操作

    constructor(
        address _nft, //nft合约地址
        uint _nftId, //nft合约中拍卖的nft
        uint _startingBid //起拍价格
    ){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender) ; //售卖者
        highestBid = _startingBid; //最高价格，刚开始，最高价格就是起拍价
    }

    // 开始事件
    function start() external {
        require(msg.sender == seller, "not seller");
        require(!started,"started");

        started = true;
        endAt = uint32(block.timestamp + 60); // 当前时间 + 60秒
        nft.transferFrom(seller, address(this), nftId); //将nft从售卖者转到当前合约中

        emit Start();
    }

    // 拍卖函数
    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value> highestBid, "value > highest bid");

        //记录上一个最高出价者的金额，方便退款操作  
        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        // 更新最高出价的人，最高出价金额
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    // 取款事件
    function withdraw() external {
        // 先查询当前账户累计拍卖金额
        uint bal = bids[msg.sender];
        // 取款后置，累计为0
        bids[msg.sender] = 0;
        // 合约向当前账户转账，该累计的金额
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    // 结束事件，结束事件的状态（结果）是确定的，所以不需要判断权限来控制，浪费gas，任何人都可以调用
    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;
        // 有人出价
        if(highestBidder != address(0)){
            // 向出价最高的人转移nft
            nft.transferFrom(address(this), highestBidder, nftId);
            // 将拍卖的钱转给出售者
            seller.transfer(highestBid);
        }else{
            // 无人出价
            //退还nft给出售者
            nft.transferFrom(address(this), seller, nftId);
        }
        
        emit End(highestBidder, highestBid);
    }
}