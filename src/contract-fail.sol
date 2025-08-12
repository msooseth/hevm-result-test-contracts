// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  mapping (address => uint) balances;
  function prove_single_fail(uint amt) public {
    assertNotEq(amt, 100);
  }
}
