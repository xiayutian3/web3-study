// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 动态调用 call(低级调用)
    // 与remix编辑器的 Low level interactions 的功能一致
// 回退函数fallback
    // 1.调用不存在的函数时会触发
    // 2.向合约中发送以太坊主币的时候


contract Caller {
    address public calleeAddress;

    constructor(address ca){
        calleeAddress = ca;
    }

    // 调用存在的函数
    function setCallSetX() public {
        // 获取函数签名数据 + 参数列表,    uint256 不能使用别名uint  一定要使用uint256
        bytes memory cd = abi.encodeWithSignature("setx(uint256)", 100); 
        (bool suc, ) = calleeAddress.call(cd);  //低级call调用
        if(!suc){
            revert("setX error");
        }
    }

    //调用不存在的函数，触发fallback
    function setCallSetY() public {
        // 获取函数签名数据 + 参数列表,    uint256 不能使用别名uint  一定要使用uint256
        // setY函数不存在
        bytes memory cd = abi.encodeWithSignature("setY(uint256)", 100); 
        (bool suc, ) = calleeAddress.call(cd);  //低级call调用
        if(!suc){
            revert("setX error");
        }
    }
    

}
