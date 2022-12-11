// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract TodoList{
    struct Todo {
        string text;
        bool completed;
    }
    Todo[] public todos;

    // 创建
    function create(string calldata _text) external {
        todos.push(Todo({
            text:_text,
            completed:false
        }));
    }

    // 更新
    function updateText(uint _index,string calldata _text) external {
        //直接修改 （用于对象单个值修改，节约gas）
        todos[_index].text = _text;

        // // 另一种修改，先将状态变量装到存储中（用于对象多个值修改,节约gas）
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;

    }

    // 获取
    function get(uint _index) external view returns(string memory, bool){
        // memory - 29480  消耗gas多
        // 原因：memory中的todo是从状态变量拷贝出一份出来的，返回值的文本，字符串类型，需要再经过拷贝一份到内存中，再返回，所以经过了两次拷贝
        Todo memory todo = todos[_index];
        return (todo.text,todo.completed);

        // // storage - 29397 消耗gas少
        // 原因：storage中的todo是直接从状态变量读出来的，返回值的文本，字符串类型，需要经过拷贝一份到内存中，再返回，只经过了一次拷贝
        // Todo storage todo = todos[_index];
        // return (todo.text,todo.completed);
    }

    // 改变状态
    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }

}