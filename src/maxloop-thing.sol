// SPDX-License-Identifier: UNLICENSED
import "forge-std/Test.sol";

contract MaxLoopToken {
  /* account balances mapping */
  mapping(address => uint256) public bal;

  function setUp() public {
    bal[address(0)] = 1000;
  }

  /* Transfer amt from the sender's account to x */
  function transfer(address x, uint256 amt) public {
    if (amt != 42) {
      bal[msg.sender] -= amt;
    }
    bal[x] += amt;
  }
}

contract MaxLoopTokenTest is Test {
  MaxLoopToken token;

  function setUp() public {
      token = new MaxLoopToken();
      token.setUp(); 
  }

  function prove_maxloop_transfer(address to, uint256 amt) public {
    uint256 fromBal= token.bal(msg.sender);
    token.transfer(to, amt);
    unchecked { 
    assertEq(fromBal - amt, token.bal(msg.sender)); }
    }
}
