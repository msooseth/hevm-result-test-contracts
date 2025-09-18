# Test contracts for hevm

These help test how hevm pretty-prints messages to users

Example use:
```plain
git clone https://github.com/ethereum/hevm/
cd hevm
nix develop .
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

# List of interesting contracts to be added
As provided by Rappie

## Balancer (0.7.x) + (0.5.12)
* https://github.com/balancer-labs/balancer-v2-monorepo/tree/master/pkg/solidity-utils/contracts/math
* https://github.com/balancer-labs/balancer-core/blob/master/contracts/BNum.sol

## BendDAO (0.8.4)
* https://github.com/BendDAO/bend-lending-protocol/tree/main/contracts/libraries/math

## Aurigami (0.8.11)
* https://github.com/Aurigami-Finance/aurigami-smart-contracts/blob/main/contracts/ExponentialNoError.sol
* https://github.com/Aurigami-Finance/aurigami-smart-contracts/blob/main/contracts/Exponential.sol

## YOLOrekt (0.8.13)
* https://github.com/YOLOrekt/community-bug-bounty/blob/bounty-head/contracts/utils/NumericalMethods.sol

## Deri protocol (0.8.x)
* https://github.com/deri-protocol/deriprotocol-v3-peripheral/tree/main/contracts/library

## Livepeer (0.8.9)
* https://github.com/livepeer/protocol/tree/confluence/contracts/libraries

# dHEDGE (0.7.6)
* https://github.com/dhedge/V2-Public/blob/master/contracts/utils/BalancerLib.sol
* https://github.com/dhedge/V2-Public/blob/master/contracts/utils/DhedgeMath.sol

## GYSR (0.8.4)
 * https://github.com/gysr-io/core/blob/master/contracts/MathUtils.sol

## Duet Finance (>=0.4.0)
* https://github.com/duet-protocol/duet-collateral-contracts/tree/main/contracts/libs

## Zenlink (>= 0.8.0)
* https://github.com/zenlinkpro/zenlink-evm-contracts/blob/main/contracts/libraries/Math.sol

## mStable (0.8.6)
* https://github.com/mstable/mStable-contracts/tree/master/contracts/shared
* https://github.com/mstable/mStable-contracts/blob/master/contracts/shared/Root.sol
* https://github.com/mstable/mStable-contracts/blob/master/contracts/shared/StableMath.solScientix (0.6.12)
* https://github.com/ScientixFinance/scientix-contract/blob/main/contracts/libraries/FixedPointMath.sol

## Divergence (^0.8.0)
* https://github.com/DivergenceProtocol/divergence-contracts--legacy/tree/820d5e963e207f326c7dd1ba4619a041b9e5d9e0/contracts/lib
* Gebaseerd op Synthetix

## Synthetix (^0.5.16)
* https://github.com/Synthetixio/synthetix/blob/develop/contracts/Math.sol
* https://github.com/Synthetixio/synthetix/blob/develop/contracts/SafeDecimalMath.sol
* https://github.com/Synthetixio/synthetix/blob/develop/contracts/SignedSafeMath.solMeer?
* https://github.com/Synthetixio/synthetix/tree/develop/contracts

## Yin Finance (^0.7.6)
* https://github.com/YinFinance/yin-core/blob/main/contracts/libraries/BinaryExp.sol

## ApeX Protocol (^0.8.0)
* https://github.com/ApeX-Protocol/core/tree/master/contracts/libraries

## Solmate (>= 0.8.0) Library (geen bounty)
* https://github.com/transmissions11/solmate/tree/main/src/utils

## Sense Finance (0.8.13)
* https://github.com/sense-finance/sense-v1/blob/dev/pkg/core/src/external/FixedMath.sol

## Aloe Protocol (^0.8.10)
* https://github.com/aloelabs/aloe-blend/tree/master/contracts/libraries

## Atlendis (^0.8.0)
* https://github.com/Atlendis/protocol-v1/tree/master/src/lib

## Gnosis Protocol (^0.7.6)
* https://github.com/gnosis/gp-v2-contracts/blob/1bfee2d8d5f4b80e5599aca6984391d708d2b151/src/contracts/libraries/SafeMath.sol

## Impossible Finance (=0.7.6)
* https://github.com/ImpossibleFinance/impossible-swap-core/tree/master/contracts/libraries

## Idle Finance (0.5.16)
* https://github.com/Idle-Labs/idle-contracts/blob/develop/contracts/libraries/DSMath.sol

## Bancor3
* https://github.com/bancorprotocol/contracts-v3/blob/dev/contracts/utility/MathEx.sol

## Resonate
* https://immunefi.com/bounty/resonate/
* Deel van Revest? https://immunefi.com/bounty/revest/
* https://github.com/Revest-Finance/ResonateContracts/blob/public/hardhat/contracts/lib/FullMath.sol

## Dinosaur Eggs (0.6.12)
* https://github.com/Dinosaur-eggs/core/tree/master/contracts/libraries

## Set Protocol
* https://github.com/SetProtocol/set-protocol-v2/tree/master/contracts/lib

## Ante Finance (>=0.7.0)
* https://github.com/antefinance/ante-v05-core/blob/v0.5/contracts/libraries/FullMath.sol

## datastructures:
* https://github.com/ajna-finance/ajna-core/blob/main/src/libraries/internal/Loans.sol
* https://github.com/ajna-finance/ajna-core/blob/main/src/libraries/internal/Deposits.sol
* https://github.com/alchemix-finance/v2-foundry/blob/8cbc07b7723050ac7df986b9fea43a2c3baf5bb5/src/libraries/Sets.sol#L4
* https://github.com/alchemix-finance/v2-foundry/blob/8cbc07b7723050ac7df986b9fea43a2c3baf5bb5/src/libraries/Tick.sol#L4
* https://github.com/alchemix-finance/v2-foundry/blob/8cbc07b7723050ac7df986b9fea43a2c3baf5bb5/src/libraries/Limiters.sol
* https://github.com/alchemix-finance/v2-foundry/blob/8cbc07b7723050ac7df986b9fea43a2c3baf5bb5/src/libraries/pools/Pool.sol
* https://github.com/alchemix-finance/v2-foundry/blob/8cbc07b7723050ac7df986b9fea43a2c3baf5bb5/src/libraries/pools/Stake.sol
