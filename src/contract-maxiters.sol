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

  function prove_maxiters_fail(uint k) public {
    require(balance < 100);
    unchecked {
    for(uint256 i = 0; i < k; i++) balance += k*1000;
    assert(balance < 1000);
    }
  }
}
