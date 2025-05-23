// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import {Test} from "forge-std/Test.sol";

contract Loopy {
    function loop(uint256 numTries) external returns(bool ok) {
        uint256 triesLeftToday = 6;
        for (uint256 i = 0; i < numTries; i++) {
            // check if tickets[i] is a winner
            unchecked { triesLeftToday--; }
        }

        ok = triesLeftToday <= 6;
    }
}

contract TestLoop is Test {
    Loopy loopy;

    function setUp() public {
        loopy = new Loopy();
    }

    function prove_loopBound(uint256 numTries) public {
        assert(loopy.loop(numTries));
    }
}
