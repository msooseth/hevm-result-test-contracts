// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test} from "forge-std/Test.sol";

contract TEST is Test {
  function check_somerevert(uint stuff) public pure {
    if (stuff == 0) revert();
  }
}
