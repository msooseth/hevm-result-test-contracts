// SPDX-License-Identifier: MIT
import {Test} from "forge-std/Test.sol";

contract MyContractTest is Test {
  mapping (address => uint) balances;
  constructor() {
    balances[address(0x1234)] = 50;
  }
  function prove_bad_addr_constructor(address x) public view {
    assert(balances[x] != 50);
  }
}
