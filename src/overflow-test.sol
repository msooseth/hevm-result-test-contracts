pragma solidity ^0.8.19;
import "ds-test/test.sol";

contract MyContract is DSTest {
  uint balance;
  function prove_overflow(uint amt) public {
    unchecked {
     balance += amt;
    }
    assert(balance > amt);
  }
}
