// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 事件与日志
// 1.日志：
// 2.合约中不能直接访问日志中的内容，可以通过sdk的方式进行交互获取
// 3.日志通过事件来实现
// 4.solidity中
//     事件是操作触发行为
//     日志是触发事件后将数据记录在区块链中
// 5.事件
//     关键：event（创建事件）
//         emit（触发事件）
// 6.事件的主题
//     6.1将事件索引化，关键字 indexed
//     6.2一个没主题的事件，无法搜索到
//     6.3一个事件，最多有4个主题
//         a.对事件的签名
//         b.对参数进行签名

contract TestEvent {

    //创建事件
    // indexed :对参数进行签名，
    event LogEvent(string indexed _name, uint indexed _age);
    // 触发事件
    function emitEvent() public {
        emit LogEvent("heelo",20);
    }

}