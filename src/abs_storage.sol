// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// import {Test} from "forge-std/Test.sol";

contract AbsStorage {
    uint256 public a;
    function inc() public {
        a++;
    }
    function not2() public {
      assert(a != 2);
    }
}
