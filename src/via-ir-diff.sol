// import "forge-std/Test.sol";
contract CheatCodes {
    function prove_warp_concrete() public {
        uint jump = 1000;
        uint pre = block.timestamp;
        uint tmp = block.timestamp + jump;
        unchecked {
          assert(tmp == pre + jump);
        }
    }
}
