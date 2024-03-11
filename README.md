## Test contracts for hevm

These help test how hevm pretty-prints messages to users

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

Running 1 test(s) for src/contract-dualfail.sol:MyContract
Exploring contract
Explored contract (9 branches)
Checking for reachability of 4 potential property violation(s)
[FAIL] prove_add_value(address,uint256,bool)
  List of counterexaple(s) follow.
  Counterexample:
    result:   Revert: 0x4e487b710000000000000000000000000000000000000000000000000000000000000001
    calldata: prove_add_value(0x0000000000000000000000000000000000000000,0,false)
  Counterexample:
    result:   Revert: 0x4e487b710000000000000000000000000000000000000000000000000000000000000001
    calldata: prove_add_value(0x0000000000000000000000000000000000000000,100,true)

Running 1 test(s) for src/contract-fail.sol:MyContract
Exploring contract
Explored contract (6 branches)
Checking for reachability of 3 potential property violation(s)
[FAIL] prove_add_value(address,uint256)
  List of counterexaple(s) follow.
  Counterexample:
    result:   Revert: 0x4e487b710000000000000000000000000000000000000000000000000000000000000001
    calldata: prove_add_value(0x0000000000000000000000000000000000000000,100)

Running 1 test(s) for src/contract-pass.sol:MyContract
Exploring contract
Explored contract (6 branches)
Checking for reachability of 3 potential property violation(s)
[PASS] prove_add_value(address,uint256)

```
