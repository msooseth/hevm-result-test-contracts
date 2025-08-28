import "forge-std/Test.sol";

contract ERC20 {

    // --- events ---

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    // --- metadata ---

    string public name;
    string public symbol;
    uint8 public immutable decimals;

    // --- erc20 data --

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => uint256) public nonces;

    // --- admin ---

    address public owner;
    modifier auth { require(owner == msg.sender, "not-authorized"); _; }

    // --- init ---

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public auth {
        _mint(to, amount);
    }

    function _mint(address to, uint256 amount) internal {
        totalSupply += amount;

        // Cannot overflow because the sum of all user
        // balances can't exceed the max uint256 value.
        unchecked {
            balanceOf[to] += amount;
        }

        emit Transfer(address(0), to, amount);
    }
}

contract SolidityTest is Test {
    ERC20 token;
    function setUp() public {
        token = new ERC20("Token", "TKN", 18);
    }
    function prove_supply(uint supply) public {
        token.mint(address(this), supply);
        uint actual = token.totalSupply();
        assertEq(supply, actual);
    }
}
