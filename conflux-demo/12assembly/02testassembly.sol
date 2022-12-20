// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// 五、字面量
// 六、变量的作用域 就是 {}
// 七、访问外部变量

contract TestAssembly {
    function testAssembly() public pure {
        assembly{
            let i := "sdf"  //赋值运算
        }
    }

    // 变量的作用域，一个{}就是一个作用域
    function test3()public pure {


        assembly {
            let x:= 2
             {
                 let y := add(x,5)
             }

             {
                //  当前作用域找不到 y
                //  let z := add(x,y)
             }
        }
    }

    // 内联汇编中能访问局部变量，不能访问状态变量
    uint outerV;
    function outerValue() public pure  returns(uint sum){
        uint innerV = 9;
        assembly {
            let y := innerV
            // let x := outerV
            sum := 90   //也能返回出90
        }
    }

    function test2() public pure returns(uint){
        //使用 add 3+5，然后和 45 进行 and 与运算
        assembly {
            let a := 3
            let b := 5

            mstore(0x1,and(add(a,b), 45)) //and 与45进行按位与 运算  //返回 8
            return (0x1,32)
        }
    }
}