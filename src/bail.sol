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
        // uint fork = vm.createSelectFork("https://eth.llamarpc.com", 21_685_331);
        counter = new Counter();
        counter.setNumber(0);
        console.log(steth.totalSupply());
        assertEq(steth.totalSupply(), 9568252847968795027664038);
        assertEq(block.number, 21_685_331);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
        assertEq(steth.totalSupply(), 9568252847968795027664038);
        assertEq(block.number, 21_685_331);
    }

    function prove_testFuzz_SetNumber(uint256 x) public {
        assertEq(block.number, 21_685_331);
        counter.setNumber(x);
        assertEq(counter.number(), x);
        assertEq(steth.totalSupply(), 9568252847968795027664038);

        // uint fork = vm.createSelectFork("https://eth.llamarpc.com", 21_685_331);
        // uint fork = vm.createFork("https://eth.llamarpc.com", 21_685_331);
        // vm.selectFork(x);
        // uint fork = vm.selectFork(21_685_331);
        // assert(1 == 1);
        // vm.selectFork(fork);
        // assertEq(block.number, 21_685_332);
        // counter = new Counter();
        // counter.setNumber(0);
        // console.log(steth.totalSupply());
        // counter.setNumber(x);
        // assertEq(counter.number(), x);
        // assertEq(steth.totalSupply(), 9568252847968795027664038);
    }
}
