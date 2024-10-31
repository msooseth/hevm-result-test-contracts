pragma solidity ^0.8.19;

import "ds-test/test.sol";

contract CopySlice is DSTest {
  function prove_copyslice(uint256 a, uint256 s) external pure returns (uint) {
    require(a < 10);
    if (a >= 8) {
      assembly {
          calldatacopy(0x5, s, s)
          a:=mload(s)
      }
      // a = 5;
    } else if (a >= 9) {
      uint256 s2 = 2 + s;
      assembly {
          calldatacopy(0x5, s2, s)
          a:=mload(s)
      }
    } else {
      assembly {
          calldatacopy(0x2, 0x2, 5)
          a:=mload(s)
      }
      a = 10;
    }
    assert(a < 20);
    return a;
  }
}
