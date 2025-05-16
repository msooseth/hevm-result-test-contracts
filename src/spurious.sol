// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test} from "forge-std/Test.sol";

contract ERC20 {
  function f() public view { }
}

contract TEST is Test {
  address[] tokens;
  address any = address(0x1234);
  mapping(address => uint256) balances;

  constructor() {
    tokens.push(address(new ERC20()));
  }

  function prove_gg(address target) public {
    balances[target] = any.balance;
    ERC20(address(tokens[0])).f(); 
  }
}
