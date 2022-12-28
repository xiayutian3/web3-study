// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10; 

import "./52ERC20.sol";

contract CrowdFund {
    // 开始事件
    event Launch(uint id, address indexed creator, uint goal, uint32 startAt, uint32 endAt);
    event Cancel(uint id); //取消事件
    event Pledge(uint indexed id, address indexed caller, uint amount); //参与众筹事件
    event Unpledge(uint indexed id, address indexed caller, uint amount); //取消参与众筹事件
    event Claim(uint id); //创建者已领取事件
    event Refund(uint indexed id, address indexed caller, uint amount);  //众筹失败，用户取回自己的钱的事件
    
    // 活动结构体
    struct Campaign {
        address creator; //活动创建者
        uint goal; //众筹目标金额
        uint pledged; //已经筹集的金额数量
        uint32 startAt; //开始时间
        uint32 endAt; //结束时间
        bool claimed; //是否已经领取众筹的金额
    }

    // 每一次众筹对应一个token地址
    IERC20 public immutable token;
    uint public count; //活动ID
    mapping(uint => Campaign) public campaigns; //筹款活动映射 活动ID -》 活动结构体
    mapping(uint => mapping(address => uint)) public pledgedAmount;  //参与筹款活动的映射 活动ID -》 参与人地址 -》 参与活动的数额

    constructor(address _token) { 
        token = IERC20(_token);
    }


    // 创建众筹
    function launch(
        uint _goal, // 众筹目标
        uint32 _startAt, //开始时间
        uint32 _endAt //结束时间
    ) external {
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator:msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false //是否已经领取过金额
        });

        emit Launch(count,msg.sender,_goal,_startAt,_endAt);
    }

    // 取消众筹函数
    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(msg.sender == campaign.creator,"not creator");
        require(block.timestamp < campaign.startAt, "started");
        delete campaigns[_id];
        emit Cancel(_id);
    }

    // 参与众筹
    function pledge(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "endAt");

        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        // 把用户的token传递到当前合约上
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
    }
    // 取消参与众筹,退回用户的钱
    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        // 直接判断过期时间即可，不需要判断开始时间，因为下面计算的时候会发生数学溢出
        require(block.timestamp <= campaign.endAt,"ended");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        // 由当前合约直接发送token给参与者
        token.transfer(msg.sender, _amount);

        emit Unpledge(_id, msg.sender, _amount);
    }
    // 当众筹达到目标时，创建众筹者可以领取token 出来
    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "not creator");
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed"); // 是否已经领取过，已经领取就不能再领取了

        campaign.claimed = true; //已领取
        //将筹集的金额发送给 众筹合约的创建者
        token.transfer(msg.sender, campaign.pledged);

        emit Claim(_id);
    }
    // 当众筹失败时，没有达到目标数字，用户可以领回自己的token
    function refund(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged < goal"); //筹集的金额小于目标金额，众筹失败

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        // 向用户发送，之前他在这个众筹合约发送的钱
        token.transfer(msg.sender, bal);

        emit Refund(_id, msg.sender, bal);
    }
}

