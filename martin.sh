#!/bin/bash

solc=$EXPSOLC
file=$1
solver="bitwuzla"
argsA="--bin --optimize --via-ir"
argsB="${argsA} --ssa-cfg-codegen"
extraArgs="--debug"

$solc ${argsA} $file 2>/dev/null | tail -n1 > a.bin
$solc ${argsB} $file 2>/dev/null | tail -n1 > b.bin

cabal run hevm -- equivalence --code-a a.bin --code-b b.bin --create --solver ${solver} ${extraArgs}
