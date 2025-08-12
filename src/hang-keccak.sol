pragma solidity ^0.8.19;

contract MyContract {
  string a;
  function prove_eq_keccak(uint x) external view {
    assert(keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(a)));
  }
}
