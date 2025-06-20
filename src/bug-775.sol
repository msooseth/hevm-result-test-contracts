
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyVault {
    mapping(address => uint256) public balance;
    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }
}

// option 1
contract Caller {}

contract SymbolicTest is Test {
    function setUp() public {
        address caller = address(new Caller());
        // option 2
        // address caller = makeAddr("alice");
        vm.deal(caller, 1 ether); // just in case...
        vm.startPrank(caller);
        new MyVault();
        new MyVault();
    }

    function prove_bug775(uint8 amt) public {
        assert(1 == 1);
      }
}
