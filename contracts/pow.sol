/*
	Copyright 2021 Algorithmic Bitcoin <algorithmbtc@protonmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
pragma solidity >=0.5.17 <0.7.0;

// SPDX-License-Identifier: MIT

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor () internal {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}


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

/*
	Copyright 2021 Algorithmic Bitcoin <algorithmbtc@protonmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
contract IABTC is IERC20 {
    function mint(address account, uint256 amount) public returns (bool);
}

/*
	Copyright 2021 Algorithmic Bitcoin <algorithmbtc@protonmail.com>
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
contract IDAO {
	function advance() external;
}

/*
	Copyright 2021 Algorithmic Bitcoin <algorithmbtc@protonmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
contract ALBitcoinPOW is ReentrancyGuard {
	using SafeMath for uint256;

	address		public 	token;			// token contract address
	address		public	liquidityPool;	// liquidity pool address
	address		public	daoAddress;		// dao address

	uint		public 	prevChangeTime;	// start period mint time
	uint		public 	lastMintTime;	// last mint time
	bytes32		public 	lastNonce;		// last nonce
	uint		public 	powHeight;		// initialize as 0
	uint		public	lastTarget;		// last target

	uint private constant BLOCK_TARGET_TIME = 3 * 10 * 60; 	// 30 minutes
	uint private constant DIFFICULTY_CHANGE_BLOCK = 3;		// 3 blocks change difficluty
	uint private constant HALVING_BLOCKS = 2100 ;			// halving block period
	uint private constant DAO_ADVANCE_BLOCKS = 50;			// every 50 blocks active step dao
	uint private constant INIT_REWARDS = 50 ether;			// 50 ABTC for the first half
	uint private constant STAGE_BLOCKS = 1050;				// there are 3 stages, from 0 ~ 1050 ~ 2100 ~ ...
	uint private constant DAO_ACTIVE_HEIGHT = 2100;			// active dao when 2100
	uint private constant MAX_POW_LIMIT = 0x000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

	event Proved(address indexed _miner, bytes32 _nonce, uint _rewards);

	struct reward_ratio {
		uint mint_percent;
		uint lp_percent;
		uint bot_percent;
	}

	mapping(uint => reward_ratio) private rewards_constant;

	constructor(
		address _token 
	) public {
		token = _token;
		paused = false;
		operator = msg.sender;
		powHeight = 0;
		lastTarget = MAX_POW_LIMIT;

		rewards_constant[0] = reward_ratio( 100, 0, 0 );
		rewards_constant[1] = reward_ratio( 50, 50, 0 );
		rewards_constant[2] = reward_ratio( 48, 48, 4 );
	}

	address private operator;
	modifier onlyOperator {
		require(msg.sender == operator, "Only operator can call this function.");
		_;
	}

	bool public paused;
	modifier notPaused() {
        require(!paused, "the contract is paused for now");
        _;
    }

	function mintToAccount(address _account, uint256 _amount) internal {
        if (_account != address(0) && _amount > 0) {
			IABTC(token).mint(_account, _amount);
		}
    }

	function pause() public onlyOperator {
		paused = true;
	}

	function setLPAddress(address _addr) public onlyOperator {
		liquidityPool = _addr;
	}

	function setDao(address _addr) public onlyOperator {
		daoAddress = _addr;
	}

	function calculateNextWorkTarget() public view returns (uint) {
		if (powHeight == 0 || ((powHeight.add(1)).mod(DIFFICULTY_CHANGE_BLOCK)) != 1) {
			return lastTarget;
		}

		// calculate new target
		uint actualTimeSpan = lastMintTime.sub(prevChangeTime);
		if (actualTimeSpan < BLOCK_TARGET_TIME / 4) {
			actualTimeSpan = BLOCK_TARGET_TIME / 4;
		} else if (actualTimeSpan > BLOCK_TARGET_TIME * 4) {
			actualTimeSpan = BLOCK_TARGET_TIME * 4;
		}

		// target = lastTarget * actualTime / expectTime;
		uint target = lastTarget.mul(actualTimeSpan).div(BLOCK_TARGET_TIME);
		if (target > MAX_POW_LIMIT) {
			target = MAX_POW_LIMIT;
		}
		return target;
	}

	function getCurrentReward() public view returns (uint _powReward, uint _lpReward) {
		uint stage = powHeight.div(STAGE_BLOCKS);
		reward_ratio memory ratio;
		if (stage > 2) {
			ratio = rewards_constant[2];
		} else {
			ratio = rewards_constant[stage];
		}

		uint newHeight = powHeight.add(1);
		_powReward = INIT_REWARDS.mul(ratio.mint_percent).div(100);
		if (stage >= 2 && newHeight >= DAO_ACTIVE_HEIGHT && (newHeight.sub(DAO_ACTIVE_HEIGHT)).mod(DAO_ADVANCE_BLOCKS) == 0) {
			if (daoAddress != address(0)) {
				// powReward = powReward + init_reward * 4% * 50;
				_powReward = _powReward.add(INIT_REWARDS.mul(ratio.bot_percent).div(100).mul(DAO_ADVANCE_BLOCKS));
			}
		}
		_lpReward = INIT_REWARDS.mul(ratio.lp_percent).div(100);

		uint period = newHeight.div(HALVING_BLOCKS);
		for (uint i = 0; i < period; i++) {
			_powReward = _powReward.div(2);
			_lpReward = _lpReward.div(2);
		}
	}

	function prove(bytes32 _nonce) public nonReentrant notPaused() {
		uint target = calculateNextWorkTarget();
		if (target != lastTarget) {
			lastTarget = target;
		}

		// plus 1 means new height
		uint newHeight = powHeight.add(1);
		if ((newHeight.mod(DIFFICULTY_CHANGE_BLOCK)) == 1) {
			prevChangeTime = block.timestamp;
		}

		// keccak256(new_height, pre_nonce, sender, my_nonce)
		bytes32 h = keccak256(abi.encodePacked(powHeight.add(1), lastNonce, msg.sender, _nonce));
		require(h <= bytes32(lastTarget), "nonce is not match");

		// you are lucky!
		(uint256 powReward, uint256 lpReward) = getCurrentReward();

		// distribute POW rewards
		mintToAccount(msg.sender, powReward);

		// distribute LP rewards
		mintToAccount(liquidityPool, lpReward);

		if (newHeight >= DAO_ACTIVE_HEIGHT && (newHeight.sub(DAO_ACTIVE_HEIGHT)).mod(DAO_ADVANCE_BLOCKS) == 0) {
			// active dao's step
			if (daoAddress != address(0)) {
				IDAO(daoAddress).advance();
			}
		}

		lastMintTime = block.timestamp;
		lastNonce = _nonce;
		powHeight = newHeight;

		emit Proved(msg.sender, _nonce, powReward);
	}
}
