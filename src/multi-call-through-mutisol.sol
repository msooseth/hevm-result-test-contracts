// SPDX-License-Identifier: UNLICENSED
import "forge-std/Test.sol";

contract Target {
    function add(uint256 x, uint256 y) external pure returns (uint256) {
      unchecked {
        return x + y;
      }
    }
}

interface MyStuff {
  function symData() external returns (bytes memory);
}

contract C is Test {
    function prove_symb_call(uint32 fst, uint32 snd) public {
        MyStuff vm = MyStuff(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
        bytes memory data = vm.symData();

        Target t = new Target();
        address realAddr = address(t);
        (bool success, bytes memory returnData) = realAddr.call(data);
        assert(success);
    }
}
