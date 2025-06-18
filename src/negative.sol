pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract Stuff is Test {
    function prove_negative(int x) public pure {
        // assert(x >= 0);
        assertGe(x, 0);
    }
}
