pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
contract MyContract is Test {
  uint[] arr2;
  uint[] arr1;
  function prove_slow(uint v, uint w) public {
    unchecked {
    require(v <= 3);
    arr2.push(w);
    arr2.push();
    arr2.push();
    arr2.push(arr2[0]-1);

    arr2[2] = v;
    arr2[1] = arr2[0]-arr2[2];
    arr1.push(arr2[v]);

    assert(arr2.length == 4);
    assert(arr2[0] == w);
    assert(arr2[1] == w-v);
    assert(arr2[2] == v);
    assert(arr2[3] == w-1);
    assert(arr1.length == 1);
    assert(arr1[0] == arr2[v]);
    }
  }
}
