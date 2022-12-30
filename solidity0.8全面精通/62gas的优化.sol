// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract GasGolf {

    // 1.start(gas)   50548
    // 2.use calldata(gas)   48803
    // 3.load state variables to memory(gas) 48592
    // 4.short circuit(gas) 48274
    // 5.loop increments(gas) --- (++i)  48244
    // 6.cache array length(gas) 48209
    // 7.load array elements to memory(gas)  48047


    uint public total;
    // [1,2,3,4,5,100]
    function sumIfEvenAndLessThan99(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for(uint i=0; i<len; ++i){
            // bool isEven = nums[i] % 2 == 0 ;
            // bool isLessThan99 = nums[i] < 99;
            // if(isEven && isLessThan99){
            //     _total += nums[i];
            // }

            
            // if(nums[i] % 2 == 0 && nums[i] < 99){
            //     _total += nums[i];
            // }

            uint num =nums[i];
            if(num % 2 == 0 && num < 99){
                _total += num;
            }
        }
        total = _total;
    }
}