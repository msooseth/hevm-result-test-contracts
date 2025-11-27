pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  uint balance;
  function prove_maxiters_pass(uint k) public {
    require(balance < 100);
    unchecked {
    for(uint256 i = 0; i < k; i++) balance += k;
    assert(balance < 1000);
    }
  }

  function f(uint a, uint k) internal {
    for(uint256 i = 0; i < k; i++) balance += k*1000;
    balance += a;
  }

  function disable_prove_maxiters_fail(uint a, uint k) public {
    require(balance < 100);
    unchecked {
      if (a < 777) {
         f(2, k);
      } else {
         f(9, k);
      }
    assert(balance < 5000);
    }
  }
}
