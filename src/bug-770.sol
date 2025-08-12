import {Test} from "forge-std/Test.sol";

contract TickTreeSearchEchidnaTest is Test {
  // bool public IS_TEST = true;
  int24 internal constant MIN_TICK = -887272;
  int24 internal constant MAX_TICK = -MIN_TICK;


  using TickTree for mapping(int16 => uint256);
  uint32 private tickTreeRoot;

  mapping(int16 => uint256) private tickSecondLayerBitmap;
  mapping(int16 => uint256) private tickBitmap;

  int24[] initedTicks;
  mapping(int24 => uint256) initedTicksIndexes;

  constructor() public {
    toggleTick(4944464);
    toggleTick(4370001);
    toggleTick(4370000);
    //prove_NextInitializedTickInvariants(-4011971);
  }

  // returns whether the given tick is initialized
  function _isInitialized(int24 tick) private view returns (bool) {
    int16 rowNumber;
    uint8 bitNumber;

    assembly {
      bitNumber := and(tick, 0xFF)
      rowNumber := sar(8, tick)
    }
    uint256 word0 = tickBitmap[rowNumber];
    unchecked {
      return (word0 & (1 << bitNumber)) > 0;
    }
  }

  function toggleTick(int24 tick) public {
    unchecked {
      if (tick < MIN_TICK) tick = MIN_TICK;
      if (tick > MAX_TICK) tick = MAX_TICK;

      assert(tick >= MIN_TICK);
      assert(tick <= MAX_TICK);
      bool before = _isInitialized(tick);
      tickTreeRoot = tickBitmap.toggleTick(tickSecondLayerBitmap, tickTreeRoot, tick);
      assert(_isInitialized(tick) == !before);

      if (!before) {
        initedTicks.push(tick);
        initedTicksIndexes[tick] = initedTicks.length - 1;
      } else {
        uint256 index = initedTicksIndexes[tick];
        if (index != initedTicks.length - 1) {
          int24 last = initedTicks[initedTicks.length - 1];
          initedTicks[index] = last;
          initedTicksIndexes[last] = index;
        }
        initedTicks.pop();
      }
    }
  }

  function _findNextTickInArray(int24 start) private view returns (int24 num, bool found) {
    uint256 length = initedTicks.length;
    if (length == 0) return (MAX_TICK, false);
    num = MAX_TICK;
    unchecked {
      for (uint256 i; i < length; ++i) {
        int24 tick = initedTicks[i];
        if (tick > start) {
          if (tick <= num) {
            num = tick;
            found = true;
          }
        }
      }
    }
  }
  function prove_NextInitializedTickInvariants(int24 tick) public view {
    // tick = -853438;
    unchecked {
      if (tick < MIN_TICK) tick = MIN_TICK;
      if (tick >= MAX_TICK) tick = MAX_TICK;

      int24 next = tickBitmap.getNextTick(tickSecondLayerBitmap, tickTreeRoot, tick);

      if (tick == MAX_TICK) {
        assert(next == MAX_TICK);
      } else {
        assert(next > tick);
        assert((next - tick) <= 2 * MAX_TICK);
        assert(next >= MIN_TICK);
        assert(next <= MAX_TICK);
        if (next != MAX_TICK) assert(_isInitialized(next));
        // all the ticks between the input tick and the next tick should be uninitialized
        (int24 nextInited, bool found) = _findNextTickInArray(tick);
        assert(nextInited == next);
        assert(_isInitialized(next) == found);
      }
    }
  }
}
library TickTree {
  int24 internal constant MIN_TICK = -887272;
  int24 internal constant MAX_TICK = -MIN_TICK;

  int16 internal constant SECOND_LAYER_OFFSET = 3466; // ceil(-MIN_TICK / 256)

  /// @notice Toggles the initialized state for a given tick from false to true, or vice versa
  /// @param leafs The mapping of words with ticks
  /// @param secondLayer The mapping of words with leafs
  /// @param treeRoot The word with info about active subtrees
  /// @param tick The tick to toggle
  function toggleTick(
    mapping(int16 => uint256) storage leafs,
    mapping(int16 => uint256) storage secondLayer,
    uint32 treeRoot,
    int24 tick
  ) internal returns (uint32 newTreeRoot) {
    newTreeRoot = treeRoot;
    (bool toggledNode, int16 nodeIndex) = _toggleBitInNode(leafs, tick); // toggle in leaf
    if (toggledNode) {
      unchecked {
        (toggledNode, nodeIndex) = _toggleBitInNode(secondLayer, nodeIndex + SECOND_LAYER_OFFSET);
      }
      if (toggledNode) {
        assembly {
          newTreeRoot := xor(newTreeRoot, shl(nodeIndex, 1))
        }
      }
    }
  }

  /// @notice Toggles a bit in a tree layer by its index
  /// @param treeLevel The level of tree
  /// @param bitIndex The end-to-end index of a bit in a layer of tree
  /// @return toggledNode Toggled whole node or not
  /// @return nodeIndex Number of corresponding node
  function _toggleBitInNode(mapping(int16 => uint256) storage treeLevel, int24 bitIndex) private returns (bool toggledNode, int16 nodeIndex) {
    assembly {
      nodeIndex := sar(8, bitIndex)
    }
    uint256 node = treeLevel[nodeIndex];
    assembly {
      toggledNode := iszero(node)
      node := xor(node, shl(and(bitIndex, 0xFF), 1))
      toggledNode := xor(toggledNode, iszero(node))
    }
    treeLevel[nodeIndex] = node;
  }

  /// @notice Returns the next initialized tick in tree to the right (gte) of the given tick or `MAX_TICK`
  /// @param leafs The words with ticks
  /// @param secondLayer The words with info about active leafs
  /// @param treeRoot The word with info about active subtrees
  /// @param tick The starting tick
  /// @return nextTick The next initialized tick or `MAX_TICK`
  function getNextTick(
    mapping(int16 => uint256) storage leafs,
    mapping(int16 => uint256) storage secondLayer,
    uint32 treeRoot,
    int24 tick
  ) internal view returns (int24 nextTick) {
    unchecked {
      tick++; // start searching from the next tick
      int16 nodeIndex;
      assembly {
        // index in treeRoot
        nodeIndex := shr(8, add(sar(8, tick), SECOND_LAYER_OFFSET))
      }
      bool initialized;
      // if subtree has active ticks
      if (treeRoot & (1 << uint16(nodeIndex)) != 0) {
        // try to find initialized tick in the corresponding leaf of the tree
        (nodeIndex, nextTick, initialized) = _nextActiveBitInSameNode(leafs, tick);
        if (initialized) return nextTick;

        // try to find next initialized leaf in the tree
        (nodeIndex, nextTick, initialized) = _nextActiveBitInSameNode(secondLayer, nodeIndex + SECOND_LAYER_OFFSET + 1);
      }
      if (!initialized) {
        // try to find which subtree has an active leaf
        // nodeIndex is now the index of the second level node
        (nextTick, initialized) = _nextActiveBitInWord(treeRoot, ++nodeIndex);
        if (!initialized) return MAX_TICK;
        nextTick = _firstActiveBitInNode(secondLayer, nextTick); // we found a second level node that has a leaf with an active tick
      }
      nextTick = _firstActiveBitInNode(leafs, nextTick - SECOND_LAYER_OFFSET);
    }
  }

  /// @notice Returns the index of the next active bit in the same tree node
  /// @param treeLevel The level of search tree
  /// @param bitIndex The starting bit index
  /// @return nodeIndex The index of corresponding node
  /// @return nextBitIndex The index of next active bit or last bit in node
  /// @return initialized Is nextBitIndex initialized or not
  function _nextActiveBitInSameNode(
    mapping(int16 => uint256) storage treeLevel,
    int24 bitIndex
  ) internal view returns (int16 nodeIndex, int24 nextBitIndex, bool initialized) {
    assembly {
      nodeIndex := sar(8, bitIndex)
    }
    (nextBitIndex, initialized) = _nextActiveBitInWord(treeLevel[nodeIndex], bitIndex);
  }

  /// @notice Returns first active bit in given node
  /// @param treeLevel The level of search tree
  /// @param nodeIndex The index of corresponding node in the level of tree
  /// @return bitIndex Number of next active bit or last bit in node
  function _firstActiveBitInNode(mapping(int16 => uint256) storage treeLevel, int24 nodeIndex) internal view returns (int24 bitIndex) {
    assembly {
      bitIndex := shl(8, nodeIndex)
    }
    (bitIndex, ) = _nextActiveBitInWord(treeLevel[int16(nodeIndex)], bitIndex);
  }

  /// @notice Returns the next initialized bit contained in the word that is to the right or at (gte) of the given bit
  /// @param word The word in which to compute the next initialized bit
  /// @param bitIndex The end-to-end index of a bit in a layer of tree
  /// @return nextBitIndex The next initialized or uninitialized bit up to 256 bits away from the current bit
  /// @return initialized Whether the next bit is initialized, as the function only searches within up to 256 bits
  function _nextActiveBitInWord(uint256 word, int24 bitIndex) internal pure returns (int24 nextBitIndex, bool initialized) {
    uint256 bitIndexInWord;
    assembly {
      bitIndexInWord := and(bitIndex, 0xFF)
    }
    unchecked {
      uint256 _row = word >> bitIndexInWord; // all the 1s at or to the left of the bitIndexInWord
      if (_row == 0) {
        nextBitIndex = bitIndex | 255;
      } else {
        nextBitIndex = bitIndex + int24(uint24(getSingleSignificantBit((0 - _row) & _row))); // least significant bit
        initialized = true;
      }
    }
  }

  /// @notice get position of single 1-bit
  /// @dev it is assumed that word contains exactly one 1-bit, otherwise the result will be incorrect
  /// @param word The word containing only one 1-bit
  function getSingleSignificantBit(uint256 word) internal pure returns (uint8 singleBitPos) {
    assembly {
      singleBitPos := iszero(and(word, 0x5555555555555555555555555555555555555555555555555555555555555555))
      singleBitPos := or(singleBitPos, shl(7, iszero(and(word, 0x00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF))))
      singleBitPos := or(singleBitPos, shl(6, iszero(and(word, 0x0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF))))
      singleBitPos := or(singleBitPos, shl(5, iszero(and(word, 0x00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF))))
      singleBitPos := or(singleBitPos, shl(4, iszero(and(word, 0x0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF))))
      singleBitPos := or(singleBitPos, shl(3, iszero(and(word, 0x00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF))))
      singleBitPos := or(singleBitPos, shl(2, iszero(and(word, 0x0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F))))
      singleBitPos := or(singleBitPos, shl(1, iszero(and(word, 0x3333333333333333333333333333333333333333333333333333333333333333))))
    }
  }
}
