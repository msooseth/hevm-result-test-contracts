#!/bin/bash
set -x

rm *.bin
rm *.yul
extraArgs="--debug --smtdebug"

solc=$EXPSOLC
file=$1
solver="bitwuzla"

$solc --bin --via-ir --optimize $file 2>/dev/null | tail -n1 > a.bin
$solc --bin --optimize --via-ir --ssa-cfg-codegen $file 2>/dev/null | tail -n1 > b.bin
$solc --bin $file 2>/dev/null | tail -n1 > c.bin
$solc --bin --optimize $file 2>/dev/null | tail -n1 > d.bin

$solc --bin --via-ir --optimize $file 2>/dev/null | tail -n1 > e.bin
$solc --bin --via-ir $file 2>/dev/null | tail -n1 > f.bin

# $solc --ir-optimized --optimize $file > a.yul
# $solc --ir-optimized --ssa-cfg-codegen $file > b.yul

# $solc --ir --via-ir $file 2>/dev/null | tail -n1 > e.yul
# $solc --ir --optimize --via-ir $file 2>/dev/null | tail -n1 > f.yul

cat a.bin
cat b.bin

./clean.sh
# cabal run hevm -- equivalence --code-a-file a.bin --code-b-file b.bin --create --solver ${solver} ${extraArgs}
# for i in `ls *.smt2`; do
#   echo "Running $i"
#   bitwuzla $i
# done


# cabal run hevm -- equivalence --code-a-file a.bin --code-b-file b.bin --create --solver ${solver} ${extraArgs}
cabal run hevm -- equivalence --code-a-file e.bin --code-b-file f.bin --create --solver ${solver} ${extraArgs}
#cabal run hevm -- equivalence --code-a-file b.bin --code-b-file d.bin --create --solver ${solver} ${extraArgs}
#cabal run hevm -- equivalence --code-a-file a.bin --code-b-file b.bin --create --solver ${solver} ${extraArgs}
#cabal run hevm -- equivalence --code-a-file d.bin --code-b-file e.bin --create --solver ${solver} ${extraArgs}
# cabal run hevm -- equivalence --code-a-file f.bin --code-b-file e.bin --create --solver ${solver} ${extraArgs}

for i in `ls *.smt2`; do
  echo "Running $i"
  bitwuzla $i
done
