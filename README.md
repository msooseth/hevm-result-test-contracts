## Test contracts for hevm

These help test how hevm pretty-prints messages to users

Gotta run with:
```
cabal run exe:hevm -- test --root tmp --max-iterations 6                                                
```
Something along the lines of:

```
$ cabal run exe:hevm -- test --root tmp 
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
