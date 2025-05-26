import {Test} from "forge-std/Test.sol";

contract ERC20 {
  function f() public view { }
}

contract TEST is Test{
  address token;
  address myaddr;

  function setUp() public{
    token = address(new ERC20());
  }

  function prove_gggghhh(address target) public {
    myaddr = target;
    ERC20(address(token)).f();
  }
}
