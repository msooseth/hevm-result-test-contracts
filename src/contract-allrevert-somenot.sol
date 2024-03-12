pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  uint256 cntr;
  function prove_allrevert_somenot_thisrevert(uint256 val) public {
      if(val < 0) {
          unchecked {
            cntr = val;
            cntr += 1;
          }
          revert();
      }
      else revert();
  }
  function prove_allrevert_somenot_thisok(uint256 val) public {
    require(cntr < 100);
    require(val < 100);
    cntr += val;
    assert(cntr < 10000);
  }
}
