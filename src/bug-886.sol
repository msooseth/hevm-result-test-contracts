// SPDX-License-Identifier: UNLICENSED

contract Bug {
   bool public IS_TEST = true;
   function prove_negative_886(int24 x) public {
    assert(x != -42);
   }
}
