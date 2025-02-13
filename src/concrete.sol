// SPDX-License-Identifier: UNLICENSED
import "forge-std/Test.sol";

contract C is Test {
    uint y;
    function setUp(uint z) public {
      y = 5;
    }
    function prove_sety(uint z) public {
      assert(5 == y);
    }
}
