// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

// IERC721接口
interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

// 荷兰拍卖
contract DutchAuction {
    uint private constant DURATION = 7 days; //拍卖时长

    IERC721 public immutable nft; //要拍卖的nft的合约地址
    uint public immutable nftId; //要拍卖的nft的合约地址里面的哪个nft

    address payable public immutable seller; //出售者
    uint public immutable startingPrice; //开始的价格
    uint public immutable startAt; //开始时间
    uint public immutable expiresAt;// 过期时间
    uint public immutable discountRate; //每秒的折扣率

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ){
        seller = payable(msg.sender);//拍卖结束后要给出售者转钱，所以payable
        startingPrice = _startingPrice; //开始价格
        discountRate = _discountRate; //折扣率
        startAt = block.timestamp; //区块当前时间
        expiresAt = block.timestamp + DURATION;

        // 开始价格一定要大于   折扣率*拍卖时长，不然会出现负数
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );

        nft = IERC721(_nft);
        nftId = _nftId;
    }

    //获取拍品当前的价格
    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    // 购买方法
    function buy() external payable {
        require(block.timestamp < expiresAt,"auction expired");

        uint price = getPrice();
        require(msg.value >= price,"ETH < price");
        //将nft转到购买者手中
        nft.transferFrom(seller,msg.sender ,nftId);
        // 退还余额
        uint refund = msg.value - price;
        if(refund > 0){
            payable(msg.sender).transfer(refund);
        }
        // 合约自毁，不仅能退回钱给出售者，还能拿回部署合约占用空间的gas费
        selfdestruct(seller); 
    }
}