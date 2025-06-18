import {Test} from "forge-std/Test.sol";

contract ERC20 {
  address any;
  function f() public { 
    any = msg.sender;
  }
}

contract TEST is Test{
  address[] tokens;
  address any = address(0x1234);
  mapping(address => uint256) balances;

  constructor() {
    tokens.push(address(new ERC20()));
  }

  function prove_ggggKKK(address target) public {
    balances[target] = any.balance;
    address(tokens[0]).delegatecall(abi.encodeWithSignature("f()"));
  }
}
