pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";

contract MyContractOverflow is Test {
  uint balance = 100;
  function prove_overflow(uint amt) public {
    unchecked {
     balance += amt;
    }
    assert(balance >= amt);
  }
}
