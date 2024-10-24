pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  struct Pair {
      uint256 x;
      uint256 y;
  }

  function prove_pass(Pair memory a) public pure {
    uint256 f = a.x;
    uint256 g = a.y;
    a.x+=a.y;
    assert(a.x == f + g);
  }
}
