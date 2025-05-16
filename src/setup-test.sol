pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";
contract MyVault {
    mapping(address => uint256) public balance;
    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }
}

contract MyVaultTest is Test {
    MyVault vault;

    // Set up environment
    function setUp() public {
        vault = new MyVault();

        address user1 = address(1);
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        vault.deposit{value: 1 ether}();
    }

    function prove_correct_setup() public {
      assertEq(vault.balance(address(1)), 1 ether);
    }
}
