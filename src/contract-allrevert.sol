pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  mapping (address => uint) balances;
  function prove_add_value(address recv, uint amt) public {
    require(balances[recv] < 100);
    if (balances[recv] + amt > 100) {
      revert();
    }
    balances[recv] += amt;
    require(amt < 1000);
    require(amt > 100);
    assert(balances[recv] > 1000);
  }
}
