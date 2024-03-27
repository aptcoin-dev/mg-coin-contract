// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.5.0;



/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20Mintable}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }
}

// File: @openzeppelin/contracts/access/Roles.sol

pragma solidity ^0.5.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

// File: @openzeppelin/contracts/access/roles/MinterRole.sol

pragma solidity ^0.5.0;


contract MinterRole is Context {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(_msgSender());
    }

    modifier onlyMinter() {
        require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter role");
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(_msgSender());
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Mintable.sol

pragma solidity ^0.5.0;


/**
 * @dev Extension of {ERC20} that adds a set of accounts with the {MinterRole},
 * which have permission to mint (create) new tokens as they see fit.
 *
 * At construction, the deployer of the contract is the only minter.
 */
contract ERC20Mintable is ERC20, MinterRole {
    /**
     * @dev See {ERC20-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the {MinterRole}.
     */
    function mint(address account, uint256 amount) public onlyMinter returns (bool) {
        _mint(account, amount);
        return true;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Capped.sol

pragma solidity ^0.5.0;

/**
 * @dev Extension of {ERC20Mintable} that adds a cap to the supply of tokens.
 */
contract ERC20Capped is ERC20Mintable {
    uint256 private _cap;

    /**
     * @dev Sets the value of the `cap`. This value is immutable, it can only be
     * set once during construction.
     */
    constructor (uint256 cap) public {
        require(cap > 0, "ERC20Capped: cap is 0");
        _cap = cap;
    }

    /**
     * @dev Returns the cap on the token's total supply.
     */
    function cap() public view returns (uint256) {
        return _cap;
    }

    /**
     * @dev See {ERC20Mintable-mint}.
     *
     * Requirements:
     *
     * - `value` must not cause the total supply to go over the cap.
     */
    function _mint(address account, uint256 value) internal {
        require(totalSupply().add(value) <= _cap, "ERC20Capped: cap exceeded");
        super._mint(account, value);
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol

pragma solidity ^0.5.0;

/**
 * @dev Optional functions from the ERC20 standard.
 */
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Burnable.sol

pragma solidity ^0.5.0;


/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev See {ERC20-_burnFrom}.
     */
    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}

// File: contracts/AptCoin.sol

pragma solidity >=0.5.0<0.6.0;



/**
 * @title coin contract
 */
contract AptCoin is ERC20Capped, ERC20Detailed, ERC20Burnable {

    // Address of coin vault
    // The vault will have all coin issued.
    address internal vault;

    // Address of  owner
    // The owner can change admin and vault address.
    address internal owner;

    // Address of coin admin
    // The admin can change reserve. The reserve is the amount of token
    // assigned to some address but not permitted to use.
    address internal admin;

    event OwnerChanged(address indexed previousOwner, address indexed newOwner);
    event VaultChanged(address indexed previousVault, address indexed newVault);
    event AdminChanged(address indexed previousAdmin, address indexed newAdmin);
    event ReserveChanged(address indexed _address, uint amount);

    /**
     * @dev reserved number of tokens per each address
     *
     * To limit token transaction for some period by the admin,
     * each address' balance cannot become lower than this amount
     *
     */
    mapping(address => uint) public reserves;

    /**
       * @dev modifier to limit access to the owner only
       */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
       * @dev limit access to the vault only
       */
    modifier onlyVault() {
        require(msg.sender == vault);
        _;
    }

    /**
       * @dev limit access to the admin only
       */
    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    /**
       * @dev limit access to owner or vault
       */
    modifier onlyOwnerOrVault() {
        require(msg.sender == owner || msg.sender == vault);
        _;
    }

    /**
     * @dev initialize ERC20
     *
     * all token will deposit into the vault
     * later, the vault, owner will be multi sign contract to protect privileged operations
     *
     * @param _symbol token symbol
     * @param _name   token name
     * @param _total          uint256
     * @param _decimals     uint8
     * @param _owner  owner address
     * @param _admin  admin address
     * @param _vault  vault address
     * @param _cap          uint256
     *
     */
    constructor (string memory _symbol, string memory _name, uint256 _total, uint8 _decimals, address _owner,
                 address _admin, address _vault, uint256 _cap)
        ERC20Detailed(_name, _symbol, _decimals) ERC20Capped(_cap * (10 ** uint(_decimals)))
    public {
        require(bytes(_symbol).length > 0);
        require(bytes(_name).length > 0);

        owner = _owner;
        admin = _admin;
        vault = _vault;

        // mint coins to the vault
        _mint(vault, _total * (10 ** uint(decimals())));
    }

    /**
     * @dev change the amount of reserved token
     *
     * @param _address the target address whose token will be frozen for future use
     * @param _reserve  the amount of reserved token
     *
     */
    function setReserve(address _address, uint _reserve) public onlyAdmin {
        require(_reserve <= totalSupply());
        require(_address != address(0));

        reserves[_address] = _reserve;
        emit ReserveChanged(_address, _reserve);
    }

    /**
     * @dev transfer token from sender to other
     * the result balance should be greater than or equal to the reserved token amount
     */
    function transfer(address _to, uint256 _value) public returns (bool) {
        // check the reserve
        require(balanceOf(msg.sender).sub(_value) >= reserveOf(msg.sender));
        return super.transfer(_to, _value);
    }

    /**
     * @dev change vault address
     *
     * @param _newVault new vault address
     */
    function setVault(address _newVault) public onlyOwner {
        require(_newVault != address(0));
        require(_newVault != vault);

        address _oldVault = vault;

        // change vault address
        vault = _newVault;
        emit VaultChanged(_oldVault, _newVault);
    }

    /**
     * @dev change owner address
     * @param _newOwner new owner address
     */
    function setOwner(address _newOwner) public onlyVault {
        require(_newOwner != address(0));
        require(_newOwner != owner);

        _addMinter(_newOwner);
        _removeMinter(owner);

        emit OwnerChanged(owner, _newOwner);
        owner = _newOwner;
    }

    /**
     * @dev change admin address
     * @param _newAdmin new admin address
     */
    function setAdmin(address _newAdmin) public onlyOwnerOrVault {
        require(_newAdmin != address(0));
        require(_newAdmin != admin);

        emit AdminChanged(admin, _newAdmin);
        admin = _newAdmin;
    }

    /**
     * @dev Transfer tokens from one address to another
     *
     * The _from's balance should be larger than the reserved amount(reserves[_from]) plus _value.
     *
     * NOTE: no one can tranfer from vault
     *
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_from != vault);
        require(_value <= balanceOf(_from).sub(reserves[_from]));
        return super.transferFrom(_from, _to, _value);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getVault() public view returns (address) {
        return vault;
    }

    function getAdmin() public view returns (address) {
        return admin;
    }

    function getOneCoin() public view returns (uint) {
        return (10 ** uint(decimals()));
    }

    /**
     * @dev get the amount of reserved token
     */
    function reserveOf(address _address) public view returns (uint _reserve) {
        return reserves[_address];
    }

    /**
     * @dev get the amount reserved token of the sender
     */
    function reserve() public view returns (uint _reserve) {
        return reserves[msg.sender];
    }
}

// File: contracts/AptCoinSafeMath.sol

pragma solidity >=0.5.0<0.6.0;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library AptCoinSafeMath {
    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        assert(b <= a);
        return a - b;
    }
}

// File: contracts/AptCoinMultiSigWallet.sol

pragma solidity >=0.5.0<0.6.0;



/**
 * @title AptCoin Multi Signature contract
 */
contract AptCoinMultiSigWallet {
    /*  Enums  */

    enum TxType {
        TRANSFER,
        SIGNER_ADD, SIGNER_REMOVE,
        ADMIN_CHANGE, VAULT_CHANGE, OWNER_CHANGE
    }

    enum TxStatus { NOT_FULLY_SIGNED, FULLY_SIGNED, EXECUTED }

    /*  Events  */

    /* Contract Created */
    event MultiSigCreated(address indexed creator, address indexed AptCoin);

    event EthReceived(address indexed sender, uint value);

    /* Tx related events */
    event TransferRequested(uint16 id, address indexed requester, address indexed to,
        uint256 amountUnitPart, uint256 amountMinunitPart, string desc);
    event SignerAddRequested(uint16 id, address indexed requester, address indexed who, string desc);
    event SignerRemoveRequested(uint16 id, address indexed requester, address indexed who, string desc);
    event OwnerChangeRequested(uint16 id, address indexed requester, address indexed who, string desc);
    event AdminChangeRequested(uint16 id, address indexed requester, address indexed who, string desc);
    event VaultChangeRequested(uint16 id, address indexed requester, address indexed who, string desc);

    event TXExecuted(uint16 id);
    event TXExecutionFailed(uint16 id);
    event TXSigned(uint16 id, address indexed who, int nth);
    event TXFullySigned(uint16 id, address indexed who, int nth);

    /* Signer change related events */
    event SignerAdded(address indexed who);
    event SignerRemoved(address indexed who);
    event SignerCannotAdded(address indexed who, string reason);
    event SignerCannotRemoved(address indexed who, string reason);

    /* for debugging */
    event DebugMsg1(string msg, uint256 value1);
    event DebugMsg1A(string msg, address value1);

    /*  Constants  */
    uint constant MAX_OWNER_COUNT = 50;
    uint256 constant MINUNIT_PER_UNIT = 1000000000; // 1e9 Minunit per Unit
    uint256 MAX_TX = 10000;

    /*  Storage  */
    struct TXRequest {
      string description;
      TxType txType;
      TxStatus status;
      address who;
      uint256 amount;
    }

    using AptCoinSafeMath for uint8;
    using SafeMath for uint256;

    mapping(address => bool) internal signerMap; // instead of iterating array, we will use this to check signer
    mapping(uint16 => TXRequest) internal requestMap; // map of requested Tx
    mapping(uint16 => address[]) internal requestSignMap; // map which contains signers who signed each Tx

    address owner;
    address[] signers;

    string public description;
    AptCoin public AptCoin;

    uint8 public requiredNoOfSign;
    uint16 internal nextTx;

    /*  Modifiers  */
    // With this modifier, the function should run using this contract's request TX functionality.
    modifier viaTXOnly() {
        require(msg.sender == address(this));
        _;
    }

    // Various owner/signer checking modifiers
    modifier senderIsOwner() {
        require(owner == msg.sender);
        _;
    }

    modifier senderIsOwnerOrSigner() {
        require(signerMap[msg.sender] || owner == msg.sender);
        _;
    }

    modifier senderIsSigner() {
        require(signerMap[msg.sender]);
        _;
    }

    modifier senderIsSignerOrSelf() {
        require(signerMap[msg.sender] || msg.sender == address(this));
        _;
    }

    modifier senderIsNotSigner() {
        require(!signerMap[msg.sender]);
        _;
    }

    modifier isSigner(address addr) {
        require(signerMap[addr]);
        _;
    }

    modifier isNotSigner(address addr) {
        require(!signerMap[addr]);
        _;
    }

    /* check the txid is valid (using the nextTx counter) */
    modifier validTxID(uint16 txid) {
        require(txid < nextTx);
        _;
    }

    modifier addressIsNotThis(address addr) {
        require(addr != address(this));
        _;
    }

    /*  Public Functions  */

    /**
     * @dev multi sign constructor
     *
     * @param _signers All signers who can sign each TX(TX means transaction stored in this wallet).
     * @param  _requiredSign Minimum number of signs for TX to be run.
     * @param _AptCoinAddress AptCoin address
     *
     */
    constructor (address[] memory _signers, uint8 _requiredSign, address _AptCoinAddress, string memory _description) public {
        require(_signers.length >= 3 && _signers.length <= MAX_OWNER_COUNT);
        require(_requiredSign >= 2);

        uint i;
        for (i = 0; i < _signers.length; ++i) {
            // check signer repetition and validity
            require(_signers[i] != address(0) && !signerMap[_signers[i]]);

            // add to map to make signership(?) check fast
            signerMap[_signers[i]] = true;
        }
        signers = _signers;

        requiredNoOfSign = _requiredSign;
        nextTx = 0;
        AptCoin = AptCoin(_AptCoinAddress);
        owner = msg.sender;
        description = _description;
        emit MultiSigCreated(owner, _AptCoinAddress);
    }

    /**
      * @dev function to request a transfer TX
      *
      * @param _to address who will get the ether
      * @param _amountUnit amount of AptCoin(Play part) to be transferred
      * @param _amountMinunit amount of AptCoin(Minunit part) to be transferred
      */
    function requestTransferInPlay(address _to, uint256 _amountUnit, uint256 _amountMinunit, string memory _description)
    public
    senderIsSigner
    returns (uint16) {
        uint256 dennis = _amountUnit.mul(MINUNIT_PER_UNIT).add(_amountMinunit);
        return requestTransferInMinunit(_to, dennis, _description);
    }

    function setRequestMapEntry(string memory _description, uint256 _amount,
        TxType _txType, TxStatus _txStatus, address _who)
    internal
    returns(uint16)
    {
        require(nextTx < MAX_TX);

        uint16 txid = nextTx++;

        requestMap[txid].description = _description;
        requestMap[txid].amount = _amount;
        requestMap[txid].txType = _txType;
        requestMap[txid].status = _txStatus;
        requestMap[txid].who = _who;

        // Add sender to list of signed person
        // Requesting a TX will also sign that TX
        requestSignMap[txid].push(msg.sender);

        return txid;
    }

    function requestTransferInMinunit(address _to, uint256 _amount, string memory _description)
    public
    senderIsSigner
    returns (uint16)
    {
        uint16 txid = setRequestMapEntry(_description, _amount,
            TxType.TRANSFER, TxStatus.NOT_FULLY_SIGNED, _to);

        uint256 amountUnit = _amount.div(MINUNIT_PER_UNIT);
        uint256 amountMinunit = _amount % MINUNIT_PER_UNIT;

        emit TransferRequested(txid, msg.sender, _to, amountUnit, amountMinunit, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    function requestSignerAdd(address _newSigner, string memory _description)
    public
    senderIsSigner
    isNotSigner(_newSigner)
    returns (uint16)
    {
        // set tx entries
        uint16 txid = setRequestMapEntry(_description, 0,
            TxType.SIGNER_ADD, TxStatus.NOT_FULLY_SIGNED, _newSigner);

        emit SignerAddRequested(txid, msg.sender, _newSigner, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    function requestSignerRemove(address _signerToRemove, string memory _description)
    public
    senderIsSigner
    isSigner(_signerToRemove)
    returns (uint16)
    {
        uint8 l = uint8(signers.length);

        // The number of signer cannot be less than the required number of signs
        if (l == requiredNoOfSign) {
            emit SignerCannotRemoved(_signerToRemove, "cannot meet no of min signs.");
            revert();
        }

        // set tx entries
        uint16 txid = setRequestMapEntry(_description, 0,
            TxType.SIGNER_REMOVE, TxStatus.NOT_FULLY_SIGNED, _signerToRemove);

        emit SignerRemoveRequested(txid, msg.sender, _signerToRemove, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    function requestOwnerChange(address _newOwner, string memory _description)
    public
    senderIsSigner
    returns (uint16)
    {
        // set tx entries
        uint16 txid = setRequestMapEntry(_description, 0,
            TxType.OWNER_CHANGE, TxStatus.NOT_FULLY_SIGNED, _newOwner);

        emit OwnerChangeRequested(txid, msg.sender, _newOwner, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    function requestVaultChange(address _newVault, string memory _description)
    public
    senderIsSigner
    returns (uint16)
    {
        // set tx entries
        uint16 txid = setRequestMapEntry(_description, 0,
            TxType.VAULT_CHANGE, TxStatus.NOT_FULLY_SIGNED, _newVault);

        emit VaultChangeRequested(txid, msg.sender, _newVault, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    function requestAdminChange(address _newAdmin, string memory _description)
    public
    senderIsSigner
    returns (uint16)
    {
        // set tx entries
        uint16 txid = setRequestMapEntry(_description, 0,
            TxType.ADMIN_CHANGE, TxStatus.NOT_FULLY_SIGNED, _newAdmin);

        emit AdminChangeRequested(txid, msg.sender, _newAdmin, _description);
        emit TXSigned(txid, msg.sender, 1);

        // 1 sign confirmation does not make transaction run, so we don't check anything in this function

        return txid;
    }

    // Any signer can run this to execute the (confirmed but not executed) TX.
    // For example, if this multi sign wallet contract does not have enough qtum for gas,
    // AptCoin.transfer will be fail with reason out of gas. Then the TX will remain
    // confirmed but not executed. Any signer can try to re-run the TX using this function
    // after send some gas fee to this contract.
    function runConfirmedTX(uint16 txid) public validTxID(txid) senderIsSigner returns(bool)
    {
        TXRequest storage request = requestMap[txid];
        require(request.status == TxStatus.FULLY_SIGNED);

        request.status = TxStatus.EXECUTED;
        if(runTX(txid)) {
            emit TXExecuted(txid);
            return true;
        } else {
            // if execution fails, rollback the status change
            request.status = TxStatus.FULLY_SIGNED;
            emit TXExecutionFailed(txid);
            return false;
        }
    }

    function runTX(uint16 txid) internal senderIsSigner returns(bool) {
        TXRequest storage request = requestMap[txid];
        if(request.txType == TxType.TRANSFER) {
            // transfer money
            AptCoin.transfer(request.who, request.amount);
        } else if(request.txType == TxType.SIGNER_ADD) {
            // NOTE: this.function() call the function externally
            //       (the sender will be this contract not the original sender)
            this.addSigner(request.who);
        } else if(request.txType == TxType.SIGNER_REMOVE) {
            this.removeSigner(request.who);
        } else if(request.txType == TxType.ADMIN_CHANGE) {
            AptCoin.setAdmin(request.who);
        } else if(request.txType == TxType.OWNER_CHANGE) {
            AptCoin.setOwner(request.who);
        } else if(request.txType == TxType.VAULT_CHANGE) {
            AptCoin.setVault(request.who);
        } else {
            return false;
        }
        return true;
    }

    /**
     * @dev sign the txid-th TX
     *
     * If the TX becomes "confirmed" status, that will be executed also.
     */
    function signTX(uint16 txid) public validTxID(txid) senderIsSigner returns (uint8) {
        TXRequest storage request = requestMap[txid];
        address[] storage requestSign = requestSignMap[txid];

        require(request.status == TxStatus.NOT_FULLY_SIGNED);

        // number of signed person
        uint8 nSigned = 0;

        uint i;
        // check if sender already signed and count all signed person
        for (i = 0; i < requestSign.length; ++i) {
            if (requestSign[i] == msg.sender) {
                // fail if already signed by the sender
                require(false);
            }
            ++nSigned;
        }

        // push the sender to the signed array and increase nSigned counter
        requestSign.push(msg.sender);
        ++nSigned;

        emit TXSigned(txid, msg.sender, nSigned);

        // if signed enough, run the transfer
        if (nSigned >= requiredNoOfSign) {
            // to prevent recursive TX call set the status EXECUTED
            request.status = TxStatus.EXECUTED;
            // execute TX
            if(runTX(txid)) {
                emit TXExecuted(txid);
            } else {
                emit TXExecutionFailed(txid);
                // set status to FULL_SIGNED to give this TX another chance to be executed manually
                request.status = TxStatus.FULLY_SIGNED;
            }
        }
        return nSigned;
    }

    function addSigner(address _newSigner)
    public
    viaTXOnly
    isNotSigner(_newSigner)
    {
        if (signers.length < MAX_OWNER_COUNT) {
            signers.push(_newSigner);
            signerMap[_newSigner] = true;
            emit SignerAdded(_newSigner);
        } else {
            emit SignerCannotAdded(_newSigner, "Cannot add a signer because of the max limit");
        }
    }

    /**
     * @dev remove a signer
     */
    function removeSigner(address _signer)
    public
    viaTXOnly
    isSigner(_signer)
    returns (bool)
    {
        uint8 l = uint8(signers.length);

        // The number of signer cannot be less than the required number of signs
        if (l == requiredNoOfSign) {
            emit SignerCannotRemoved(_signer, "cannot meet no of min signs.");
            return false;
        }

        uint16 i;

        // find the signer
        for (i = 0; i < l; ++i) {
            if (signers[i] == _signer) {
                break;
            }
        }
        //emit DebugMsg1("found ", i);

        // We should be able to find the signer in the loop above.
        // So if i==l-1, _signer is the last element, so we do not need to do anything.
        // And if not move remaining elements a slot forward
        if (i < l.sub(1)) {
            for (++i; i < l; i++) {
                signers[i - 1] = signers[i];
                //emit DebugMsg1A("moved", signers[i - 1]);
            }
        }
        // decrease array length
        signers.length--;
        signerMap[_signer] = false;
        emit SignerRemoved(_signer);
        return true;
    }

    /**
     * @dev return the transaction status in txid-th TX
     *
     * Some client cannot parse structure stored. So, instead of returning whole structure at once,
     * this function returns n-tuple.
     */
    function viewTX(uint16 txid)
    public
    view
    validTxID(txid)
    senderIsSigner
    returns(string memory, TxType, TxStatus, address, uint256, uint256)
    {
        TXRequest memory request = requestMap[txid];
        uint256 amount = request.amount;
        uint256 amountUnit = amount.div(MINUNIT_PER_UNIT);
        uint256 amountMinunit = amount % MINUNIT_PER_UNIT;
        return (
        request.description,
        request.txType,
        request.status,
        request.who,
        amountUnit,
        amountMinunit
        );
    }

    /**
     * @dev returns list of addresses who sign the TX
     */
    function viewWhoSignTX(uint16 txid) public view validTxID(txid) senderIsSigner returns (address[] memory) {
        return requestSignMap[txid];
    }

    /**
     * @dev returns how many TX stored in this contract
     */
    function getTxCount() public view returns (uint16) {
        return nextTx;
    }

    /**
     * @dev get the list of signers
     *
     * Only owner or signer can call this function
     */
    function getSigners() public view senderIsOwnerOrSigner returns (address[] memory) { return signers; }
}
