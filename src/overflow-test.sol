pragma solidity ^0.8.19;
//import "ds-test/test.sol";

contract MyContract {
  uint balance = 100;
  function test_overflow(uint amt) public {
    unchecked {
     balance += amt;
    }
    assert(balance >= amt);
  }
}
