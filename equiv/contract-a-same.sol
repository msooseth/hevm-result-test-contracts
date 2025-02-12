            contract C {
              uint x;
              constructor() {
                x = 0;
              }
              function stuff(uint a) public returns (uint256) {
                unchecked {
                return (a<<1)+x;
                }
              }
            }
