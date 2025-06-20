/// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.26;
import {Test} from "forge-std/Test.sol";

contract MyVault {
    mapping(address => uint256) public balance;
    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }
}

contract SymbolicTest is Test {
    function setUp() public {
        address caller = address(0xdead);
        vm.startPrank(caller);
        new MyVault();

        // Without this line, setUp and the whole
        // test suite completes without issues.
        new MyVault();
    }

    function prove_227(uint8 amt) public {
        assert(1 == 1);
      }
}
