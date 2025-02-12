            interface Vm {
              function nonexist(uint256) external;
            }
contract C {
              uint x;
              function stuff(uint a) public returns (uint256) {
                Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
                vm.nonexist(5);
                unchecked {
                return (a*2);
                }
              }
            }
