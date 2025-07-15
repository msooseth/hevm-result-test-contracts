contract C {
  uint x;
  constructor(bool a) {
    if (a) {
      x = 1;
    }
    else {
      x = 0;
    }
  }
  function stuff(uint a) public returns (uint256) {
    unchecked {
    return (a<<1)+x;
    }
  }
}
