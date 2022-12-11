// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        //定义的三种方法
        Car memory toyota = Car("Toyota",1990,msg.sender);
        Car memory lambo = Car({year:1980,model:"Lambo",owner:msg.sender});
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari",2020,msg.sender));

        // 获取值、
        Car memory _car1 = cars[0];  //不能对数据进行修改，读取在内存中
        _car1.year;
        _car1.model;

        //修改数据
        Car storage _car = cars[0]; // 定义在存储中就可以对结构体的数据进行修改，把状态变量读取出来，并且是带有指针式的读取
        _car.year = 1999;
        delete _car.owner;  // 被删除的数据会恢复到默认状态,并不是真正的删除

        delete cars[1]; // 被删除的数据会恢复到默认状态,并不是真正的删除
    }
}