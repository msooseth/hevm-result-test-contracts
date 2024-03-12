pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  mapping (address => uint) balances;
  uint balance;

  function prove_dual_diff_func1(address recv, uint amt) public {
    unchecked{
    require(balance < 10);
    balance += amt;
    assert(balance > 1000);
    }
  }
  function prove_dual_diff_func2(address recv, uint amt) public {
    unchecked{
    require(balances[recv] < 10);
    balances[recv] += amt;
    assert(balances[recv] > 1000);
    }
  }
}
