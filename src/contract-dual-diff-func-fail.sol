pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  mapping (address => uint) balances;
  uint balance;

  function prove_add_value2(address recv, uint amt) public {
    unchecked{
    require(balance < 10);
    for (uint256 i = 0; i < 10; i++) balance += amt;
    assert(balance > 1000);
    }
  }
  function prove_add_value(address recv, uint amt) public {
    unchecked{
    require(balances[recv] < 10);
    for (uint256 i = 0; i < 10; i++) balances[recv] += amt;
    assert(balances[recv] > 1000);
    }
  }
}
