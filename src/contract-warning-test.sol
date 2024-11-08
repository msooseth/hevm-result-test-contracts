pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract WarningTest is Test {
  mapping (address => uint) balances;
  function prove_pass(address recv, uint amt) public {
    require(balances[recv] < 100);
    if (balances[recv] + amt >= 100) {
      revert();
    }
    balances[recv] += amt;
    assert(balances[recv] < 100);
  }
  function prove_warning(uint a, uint b) public {
    require(a < 100);
    require(b < 100);
    assertTrue(a+b < 200, "OK");
  }
  function prove_nowarning(uint a, uint b) public {
    require(a < 100);
    require(b < 100);
    assertTrue(a+b < 200);
  }
  function prove_error(uint a, uint b) public {
    assertTrue(a+b < 200);
  }
}
