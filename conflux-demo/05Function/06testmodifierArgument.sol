// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

// modifier 修饰器 （带参数）

contract TestModifierArgument {
    //游戏玩家 等级 》5 可以修改昵称  》10可以修改皮肤颜色
    uint public level = 0;
    string public name;
    string public skinColor;

    //修改器
    modifier levelRequire(uint _level){
        require(level > _level);
        _;
    }

    function setName() public levelRequire(5) {
        // if(level > 5){
        //     name="heelo";
        // }

        //添加修改器后
        name="heelo";
    }
    function setSkinColor() public levelRequire(10) {
        // if(level > 10){
        //     skinColor = "red";
        // }


        //添加修改器后
         skinColor = "red";
    }
    function setLevel(uint _level) public {
        level = _level;
    }
}