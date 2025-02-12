            contract C {
              uint x;
              uint private immutable CONST_NUM;
              constructor(uint k) {
                CONST_NUM = k;
              }
              function stuff(uint a) public returns (uint256) {
                unchecked {
                return (a<<1)+CONST_NUM;
                }
              }
            }
