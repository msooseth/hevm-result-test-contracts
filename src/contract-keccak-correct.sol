// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  mapping (address => uint) balances;
  function setUp() public {
    balances[address(0xfaaaaaffafafafafaaaaa472134)] = 50;
  }
  function prove_keccak_correct(address addr, uint amt) public view {
    require(amt > 0);
    uint balance = balances[addr];
    assert(balance != 50);
  }
}
