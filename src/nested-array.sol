pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

contract MyContract is Test {
  uint[][] arr2;
  function prove_nested_append(uint v, uint w) public {
    arr2.push([v,w]);
    arr2.push();
    arr2.push();

    arr2[1].push(arr2[0][0]);

    arr2[2].push(w);
    // TODO: this is the problematic line!
    // changing this to arr2[1].push(1), and updating the assertion for the
    // value of arr2[1][1] to reflect the change makes this test pass...
    arr2[1].push(w);

    assert(arr2.length == 3);

    assert(arr2[0].length == 2);
    assert(arr2[0][0] == v);
    assert(arr2[0][1] == w);

    assert(arr2[1].length == 2);
    assert(arr2[1][0] == v);
    assert(arr2[1][1] == w);

    assert(arr2[2].length == 1);
    assert(arr2[2][0] == w);
  }
}
