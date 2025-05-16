pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";

contract MyVault {
    mapping(address => uint256) public balance;
    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }
}
contract Stuff is Test {
      MyVault vault;
      function setUp() public {
        vault = new MyVault();

        address user1 = address(1);
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        vault.deposit{value: 1 ether}();

        address user2 = address(2);
        vm.deal(user2, 1 ether);
        vm.prank(user2);
        vault.deposit{value: 1 ether}();
    }

    function prove_anja2(uint8 amt) public {
        address k = address(1);
        uint pre = vault.balance(k);
        vm.prank(k);
        vault.deposit{value: amt}();
        assert(vault.balance(k) == pre + amt);
      }
}
