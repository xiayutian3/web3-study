// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.8.0; 
pragma experimental ABIEncoderV2;

// 结构体
// 1.关键字 struct
// 2.引用类型
// 3.大部分的类型都可，但是不可以包含自己本身
// 4.结构体作为函数的返回值类型使用时，
//     1.结构体中有mapping类型：函数只能使用 internal，private
//     2.结构体中没有mapping类型：需要添加 pragma experimental ABIEncoderV2;


contract TestStruct {
    // 结构体
    struct Student {
        uint id;
        string name;
        // mapping(string => uint) grade;
        // uint[] array;
    }
    Student st; // 状态变量

    // 初始化结构体
    constructor() public {
        // mapping不能直接用下面的这种方式赋值
        Student memory stu = Student(1,'hell'); //按顺序赋值
        // Student memory stu = Student({name:'hell',id:2}); //按命名方式赋值也行

        st = stu;
        // 单独拿出来 ，这样才能赋值mapping数据类型
        // st.grade['jj'] = 45;
    }


    // 得到结构体
    function get() public view returns(Student memory){
        return st;
    }
}