pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";

contract ArrayTest is Test {
  mapping (address => uint) balances;
  function prove_initial_values(address x) public {
          // require(x != address(0));
          assert(balances[x] == 0);
  }
}
