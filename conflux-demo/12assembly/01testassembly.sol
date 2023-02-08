// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 一、solidity汇编语言概念
//     solidity汇编语言，采用自己独特的语言风格，使编写的代码的可读性更强，且能够直接与evm交互，而且可以减少gas的消耗
// 二、solidity汇编语言分类
//     1.内联汇编
//     2.独立汇编
// 三、solidity内联汇编语言的作用
//     1.可以直接嵌入到solidity的源代码中使用
//     2.代码的可读性更强
//     3.直接访问栈
//     4.可以节省gas的消耗
//     5.但是安全性不好，因为可以直接访问栈
// 四、solidity的内联汇编为我们提供的下述的特性
//     1.函数式操作码：mul(1,add(2,3))代替 push1 3 push1 2 add push1 1 mul
//     2.汇编局部变量：let x:=add(2,3) let y:=mload(0x40) x:=add(x,y)
//     3.访问外部变量：function f(uint x){assembly {x:= sub(x,1)}}
//     4.标签：let x:= 10 repeat: x:=sub(x,1) jumpi(repeat,eq(x,0))  ------已废弃，不安全
//     5.循环：for{let i:=0} lt(i,x){i:=add(i,1)}{y:=mul(2,y)}
//     6.switch语句：switch x case 0 {y:=mul(x,2)} default {y:=0}
//     7.函数调用：function f(x) -> y{switch x case 0 {y:=1} default {y:=mul(x,f(sub(x,1)))} }
// 五、字面量
//     1.整型常量：10进制 16进制
//     2.字符串： “kk”
//     案例：使用3+5，然后和“abc”进行与运算
// 六、变量的作用域 就是 {}
// 七、访问外部变量
//     1.内联汇编中能访问局部变量
//     2.不能访问状态变量
// 八、流程控制语句
//     1.判断语句
//         if：无else，不能用if做多选择
//         switch：做多选择（solidity中没有switch语句）
//     2.循环
//         for
//     3.无 跳转语句 break ，return
// 九、函数声明与调用



// 案例 求 1到n的和 sum？
contract TestAssembly {

    // function testSum(uint n) public pure returns(uint){
    //     uint sum = 0;
    //     for(uint i=0; i<n; i++){
    //         sum+=i;
    //     }
    //     return sum;
    // }

    // 如果返回值有参数 sum，就不需要在函数体内定义sum了,返回值也不需要写，会自动返回同名的sum
    function testSum(uint n) public pure returns(uint sum){
        for(uint i=0; i<n; i++){
            sum+=i;
        }
    }


    // assembly 内联汇编语言写法
    function testAssembly(uint n) public pure returns(uint){
        assembly{
            let sum := 0  //let 定义变量， := 是赋值，结尾不能有分号
            for{ let i:= 1 } lt( i,n ) { i := add(i,1) }{  // 语句块 条件 语句块，语句块都是写在大括号里面
                sum := add(sum,i)
            }

            mstore(0x0,sum)  //返回值，先存再取值，加载到内存中，再返回
            return(0x0,32)  //在返回出来（32个字节来存储数据）
        }
    }
    

}