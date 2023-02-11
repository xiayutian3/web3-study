
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// original code
// https://github.com/optionality/clone-factory/blob/master/contracts/CloneFactory.sol


// 使用场景：适用于处理逻辑的合约不通过构造函数传递值的情况

// bytecode的结构
// 1.init code
// 2.Runtime code
// 3.Runtime code中的元数据区
// 4.注意：没有构造参数；没有函数选择逻辑；程序执行入口

contract MyMinimalProxyFactory {
    function clone(address target) external returns (address result) {
        // convert address to 20 bytes
        bytes20 targetBytes = bytes20(target);

        //  bytecode的结构
        // actual code //  
        // 3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe5af43d82803e903d91602b57fd5bf3
        // 这个是我们自己固化在里边的地址   0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
        // 6080604052348015600f57600080fd5b5060738061001e6000396000f3fe60806040523660008037600080366000739d7f74d0c41e726ec95884e0e97fa6129e3b5e995af43d6000803e80600081146038573d6000f35b3d6000fdfea26469706673582212200dc2e186306f6e389f629f4d2cc9972c5ba4304a7b36384bc190dd8c2321369164736f6c63430008070033
        // 第二个fe是元数据（可以不要） 结构： 初始化代码 + fe + runtime code + fe +元数据
        // 6080604052348015600f57600080fd5b5060738061001e6000396000f3fe6080 604052366000803760008036600073   长度16+16+15
        // 9d7f74d0c41e726ec95884e0e97fa6129e3b5e99 长度 20
        // 5af43d6000803e80600081146038573d6000f35b3d6000fd 长度 24


        // creation code //
        // copy runtime code into memory and return it
        // 3d602d80600a3d3981f3

        // runtime code //
        // code to delegatecall to address
        // 363d3d373d3d3d363d73 address 5af43d82803e903d91602b57fd5bf3

        assembly {
            /*
            reads the 32 bytes of memory starting at pointer stored in 0x40

            In solidity, the 0x40 slot in memory is special: it contains the "free memory pointer"
            which points to the end of the currently allocated memory.
            */
            let clone := mload(0x40)
            // store 32 bytes to memory starting at "clone"
            mstore(
                clone,
                0x6080604052348015600f57600080fd5b5060738061001e6000396000f3fe6080
            )
            mstore(
                add(clone,32), //再偏移32字节
                0x6040523660008037600080366000730000000000000000000000000000000000
            )

            /*
              |              20 bytes                |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
                                                      ^
                                                      pointer
            */
            // store 32 bytes to memory starting at "clone" + 20 bytes
            // 0x14 = 20
            mstore(add(clone, 47), targetBytes)

            /*
              |               20 bytes               |                 20 bytes              |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe
                                                                                              ^
                                                                                              pointer
            */
            // store 32 bytes to memory starting at "clone" + 40 bytes
            // 0x28 = 40
            mstore(
                add(clone, 67),
                0x5af43d6000803e80600081146038573d6000f35b3d6000fd0000000000000000
            )

            /*
              |               20 bytes               |                 20 bytes              |           15 bytes          |
            0x3d602d80600a3d3981f3363d3d373d3d3d363d73bebebebebebebebebebebebebebebebebebebebe5af43d82803e903d91602b57fd5bf3
            */
            // create new contract
            // send 0 Ether
            // code starts at pointer stored in "clone"
            // code size 0x37 (55 bytes)
            result := create(0, clone, 91)
        }
    }
}


