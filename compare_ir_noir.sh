cp foundry.toml.noir foundry.toml
forge clean
forge build --ast
jq -r '.deployedBytecode.object' out/via-ir-diff.sol/CheatCodes.json > without-via-ir

cp foundry.toml.ir foundry.toml
forge clean
forge build --ast
jq -r '.deployedBytecode.object' out/via-ir-diff.sol/CheatCodes.json > with-via-ir

# cp with-via-ir with-via-ir.code
# cp without-via-ir without-via-ir.code
# cabal run -f devel exe:hevm -- equivalence --code-a "$(<tmp/without-via-ir)" --code-b "$(<tmp/with-via-ir)"
