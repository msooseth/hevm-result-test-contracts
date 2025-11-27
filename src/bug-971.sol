contract C917 {
	bool public IS_TEST = true;
	uint256 state;
	function prop() public {
		assert(state == 0);
	}
	function inc() external { state++; }
        function prove_callAndCheckProperty(bytes32 arr) external {
        address target = address(this);
        bool success;

        assembly {
            // Allocate memory for the calldata copy
            let dataPtr := mload(0x40)
            let dataLen := 32

            // Copy calldata (after 4-byte selector) into memory
            calldatacopy(dataPtr, 0x04, dataLen)

            // Update the free memory pointer
            mstore(0x40, add(dataPtr, dataLen))

            // Perform the low-level call
            success := call(gas(), target, 0, dataPtr, dataLen, 0, 0)
        }

        if (!success) revert("raw call failed");
        prop();
    }

}
