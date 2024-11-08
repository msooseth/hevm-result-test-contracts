pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract TupleTest is Test {
  struct Pair {
      uint256 x;
      uint256 y;
  }

  function prove_tuple_pass(Pair memory a) public pure {
    uint256 f = a.x;
    uint256 g = a.y;
    unchecked {
      a.x+=a.y;
      assertTrue(a.x == f + g);
    }
  }
}
