pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract TupleTest is Test {
  struct MyPair {
      uint256 x;
      uint256 y;
  }
  function prove_tuple_pass(MyPair memory a) public pure {
    uint256 f = a.x;
    uint256 g = a.y;
    unchecked {
      a.x+=a.y;
      assert(a.x == (f + g));
    }
  }
  function prove_tuple_pass1(uint256[5] memory amounts) public pure {
    assert(amounts[0] == 10);
  }
  function prove_tuple_pass2(uint256 amounts) public pure {
    assert(amounts == 10);
  }
}
