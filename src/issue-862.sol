pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract Counter {
    uint256 public number;

    function increment() public {
        number++;
    }
}

contract CounterSymTest is Test {
    Counter public counter;

    constructor() {
        counter = new Counter();
    }

    function prove_isIncrementFeasible() public {
        vm.assume(counter.number() != 2);
        counter.increment();
        assertTrue(!(counter.number() == 2), "number is 2");
    }
}
