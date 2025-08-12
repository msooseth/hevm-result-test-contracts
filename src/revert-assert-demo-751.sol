// SPDX-License-Identifier: UNLICENSED
import "forge-std/Test.sol";
contract RevertAssertDemoTest is Test {
    function prove_func_751(uint256 revertControlInput) public {
        if (revertControlInput == 0) {
            revert();
        }
        assert(true);
    }
} 
