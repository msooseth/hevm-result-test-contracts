
import {Test} from "forge-std/Test.sol";

contract T is Test {
    int128 private constant MIN_64x64 = -0x80000000000000000000000000000000;
    int128 private constant MAX_64x64 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    int128 internal ZERO_FP = fromInt(0);
    int128 internal ONE_FP = fromInt(1);
    int128 internal MINUS_ONE_FP = fromInt(-1);
    int128 internal TWO_FP = fromInt(2);
    int128 internal THREE_FP = fromInt(3);
    int128 internal EIGHT_FP = fromInt(8);
    int128 internal THOUSAND_FP = fromInt(1000);
    int128 internal MINUS_SIXTY_FOUR_FP = fromInt(-64);
    int128 internal ONE_TENTH_FP = div(fromInt(1), fromInt(10));
    int128 internal ONE_MILL_FP = div(fromInt(1), fromInt(1_000_000));

  function fromInt (int256 x) internal pure returns (int128) {
    unchecked {
      require (x >= -0x8000000000000000 && x <= 0x7FFFFFFFFFFFFFFF);
      return int128 (x << 64);
    }
  }

  function div (int128 x, int128 y) internal pure returns (int128) {
    unchecked {
      require (y != 0);
      int256 result = (int256 (x) << 64) / y;
      require (result >= MIN_64x64 && result <= MAX_64x64);
      return int128 (result);
    }
  }

  function abs (int128 x) internal pure returns (int128) {
    unchecked {
      require (x != MIN_64x64);
      return x < 0 ? -x : x;
    }
  }

  function inv (int128 x) internal pure returns (int128) {
    unchecked {
      require (x != 0);
      int256 result = int256 (0x100000000000000000000000000000000) / x;
      require (result >= MIN_64x64 && result <= MAX_64x64);
      return int128 (result);
    }
  }

    function prove_inv_identity(int128 x) public view {
        require(x != ZERO_FP);

        int128 inv_x = inv(x);
        int128 identity = mul(inv_x, x);

        // They should agree with a tolerance of one tenth of a percent
        assert(equal_within_tolerance(identity, ONE_FP, ONE_TENTH_FP));
    }

  function mul (int128 x, int128 y) internal pure returns (int128) {
    unchecked {
      int256 result = int256(x) * y >> 64;
      require (result >= MIN_64x64 && result <= MAX_64x64);
      return int128 (result);
    }
  }

  function sub (int128 x, int128 y) internal pure returns (int128) {
    unchecked {
      int256 result = int256(x) - y;
      require (result >= MIN_64x64 && result <= MAX_64x64);
      return int128 (result);
    }
  }

  function fromUInt (uint256 x) internal pure returns (int128) {
    unchecked {
      require (x <= 0x7FFFFFFFFFFFFFFF);
      return int128 (int256 (x << 64));
    }
  }

  function equal_within_tolerance(
      int128 a,
      int128 b,
      int128 error_percent
  ) public pure returns (bool) {
      int128 ref = abs(a) > abs(b) ? abs(a) : abs(b); 
      int128 tol_value = abs(mul(ref, div(error_percent, fromUInt(100))));

      return (abs(sub(b, a)) <= tol_value);
  }
}
