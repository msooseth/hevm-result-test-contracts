pragma solidity ^0.8.13;
import "forge-std/Test.sol";

contract Counter {
    uint256 public number;

    function increment() public {
      unchecked {
        number++;
      }
    }
}

contract CounterSymTest is Test {
    Counter public counter;

    function setUp () public {
        counter = new Counter();
        address hevm = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
        (bool success, ) = hevm.call(abi.encodeWithSelector(bytes4(keccak256("symbolify(address)")), address(counter)));
        require(success, "Call to hevm.symbolify failed");
    }

    function prove_isIncrementFeasible() public {
        vm.assume(counter.number() != 2);
        counter.increment();
        assertTrue(!(counter.number() == 2), "number is 2");
    }
}
