## Test contracts for hevm

These help test how hevm pretty-prints messages to users

Example use:
```plain
git clone https://github.com/ethereum/hevm/
cd hevm
git clone https://github.com/msooseth/hevm-result-test-contracts
cd hevm-result-test-contracts
git submodule init
git submodule update
forge build --ast
cd ..
cabal run exe:hevm -- test --root "hevm-result-test-contracts"
```

You should be getting something like:

```plain
Running 1 test(s) for src/contract-allrevert.sol:MyContract
Exploring contract
Explored contract (8 branches)
Checking for reachability of 5 potential property violation(s)
[PASS] prove_add_value(address,uint256)

Running 1 test(s) for src/contract-bail.sol:MyContract
Exploring contract
Explored contract (8 branches)
Checking for reachability of 4 potential property violation(s)
[FAIL] prove_add_value(address,uint256)
Failure: prove_add_value(address,uint256)
  No reachable assertion violations, but all branches reverted
  Prefix this testname with `proveFail` if this is expected
```
