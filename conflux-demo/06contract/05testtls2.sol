// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 

// 继承中的重写

contract Father {
    uint age = 60;
    // 父类添加 virtual 
    // public -》 external（重写的限制）
    function eat() public virtual pure returns(string memory){
        return "rou";
    }
}

contract Son is Father {
    // uint age = 12;  //状态变量不能重写  0.6.0版本以后

    //solidity 重写的限制
        // 1.函数名，函数的参数，返回值类型不能修改
        // 2.函数的可见性可以修改，但是范围不能小于父类
        // 3.存在继承关系


    //子类添加 override 重写
    function eat() public override pure returns(string memory){
        return "fish";
    }

    
    function test() public pure returns(string memory){
        // return eat(); //子类的eat方法起作用
        // return super.eat(); //父类的eat方法起作用  super是采用内部调用的方式
        return Father.eat(); // 父类的eat方法起作用  Father 也是内部调用的方式

        // super.age;  //不能访问父类的状态变量
        // Father.age; // 可以访问 父类的状态变量
    }



    //函数的重载，不是重写 ，体现多态性
        // 1.在同一个合约当中
        // 2.函数的名字相同，参数的类型，个数不同，返回值类型无所谓，就是函数的重载
    function eat(string memory _m) public pure returns(string memory){
        return _m;
    }

    // 新增的函数
    function drink() public pure returns(string memory){
        return "water";
    }

}