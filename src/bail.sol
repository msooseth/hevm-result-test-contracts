// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

interface IERC20 {
    function totalSupply() external view returns (uint256);
}

contract CounterTest is Test {
    Counter public counter;
    IERC20 steth = IERC20(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);

    function setUp() public {
        vm.createSelectFork("https://eth.llamarpc.com", 21_685_331);
        counter = new Counter();
        counter.setNumber(0);
        console.log(steth.totalSupply());
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function prove_testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
        assertEq(steth.totalSupply(), 9568252847968795027664038);
    }    
}
