// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// 浮点型 
// fixed / ufixed：表示各种大小的有符号和无符号的定长浮点型。 
// 在关键字 ufixedMxN 和 fixedMxN 中，M 表示该类型占用的位数，N 表示可用的小数位数。 
// M 必须能整除 8，即 8 到 256 位。 N 则可以是从 0 到 80 之间的任意数。
contract TestFixed {

    fixed16x6 fix;
}