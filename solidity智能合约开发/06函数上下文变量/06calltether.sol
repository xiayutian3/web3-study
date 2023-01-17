// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 测试调用goerli testnet usdt 的合约

// goerli testnet usdt 的合约地址 0x509Ee0d083DdF8AC028f2a56731412edD63223B9
// // 使用步骤
//     1.将网络切换至  goerli testnet
//     2.将地址放到remix 部署界面的 At Address 中加载即可（加载已经部署在goerli testnet上的合约）

// interface中的函数都是 external的，可以部署interface，就能可直接调用，（这个是remix帮我们完成的）
interface MyTether { 
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint);
}

// 也可以写自己的一个test测试合约(然后部署在 goerli testnet上)，去调用 goerli testnet usdt 的合约
contract Caller {
    address public calleeAddress;

    constructor(address ca){
        calleeAddress = ca;
    }
    function getTetherName() external view returns (string memory) {
        MyTether tether = MyTether(calleeAddress); //转换为 MyTether 的地址合约调用，,用 MyTether类型去重载地址
        return tether.name();
    }
    
    // 自毁合约，如果有余额，强制发送剩余主币 给 msg.sender， msg.sender默认没有payable属性
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

}