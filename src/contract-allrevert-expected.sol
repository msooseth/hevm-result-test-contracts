pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  uint256 cntr;
  function proveFail_allrevert_expected(uint256 val) public {
      if(val < 0) {
          unchecked {
            cntr = val;
            cntr += 1;
          }
          revert();
      }
      else revert();
  }
}
