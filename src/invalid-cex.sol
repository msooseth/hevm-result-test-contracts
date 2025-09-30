contract MyContractTest is Test {
  mapping (address => uint) balances;
  function setUp() public {
    balances[address(0x1234)] = 50;
  }
  function prove_balance(address x) public view {
    assert(balances[x] != 40);
  }
}
