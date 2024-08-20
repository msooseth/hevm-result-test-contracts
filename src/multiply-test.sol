pragma solidity ^0.8.19;
//import "ds-test/test.sol";

contract MyContract {
  uint balance;
  function prove_multiply(uint amt, uint amt2) public {
    require(amt != 1);
    require(amt2 != 1);
    require(amt < amt2);
    uint tmp;
    tmp = amt * amt2;
    if (tmp == 119274257) balance = 1337;
    else balance += tmp;
    assert(balance >= tmp);
  }
}
