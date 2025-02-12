            contract C {
              uint x;
              function stuff(uint a) public returns (uint256) {
                unchecked {
                return (a*2)+x;
                }
              }
            }
