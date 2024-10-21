import "forge-std/Test.sol";
contract OutOfBounds is Test {
              uint[] private arr;
              function prove_fun(uint8 a) external returns (uint x){
                arr.push(a);
                assert(a == arr[0]);
              }
             }

