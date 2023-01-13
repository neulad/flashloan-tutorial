// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import {IERC20} from '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

contract Dex {
    address payable public owner;

    // Aave ERC20 Token addresses on Goerli network
    address constant DAI_ADDRESS = 0xDF1742fE5b0bFc12331D8EAec6b478DfDbD31464;
    address constant USDC_ADDRESS = 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43;

    IERC20 private immutable i_dai;
    IERC20 private immutable i_usdc;

    // exchange rate indexes
    uint256 dexARate = 90;
    uint256 dexBRate = 100;

    // keeps track of individuals' dai balances
    mapping(address => uint256) private s_daiBalances;

    // keeps track of individuals' USDC balances
    mapping(address => uint256) private s_usdcBalances;

    constructor() {
        owner = payable(msg.sender);
        i_dai = IERC20(DAI_ADDRESS);
        i_usdc = IERC20(USDC_ADDRESS);
    }

    function depositUSDC(uint256 _amount) external {
        s_usdcBalances[msg.sender] += _amount;
        uint256 allowance = i_usdc.allowance(msg.sender, address(this));
        require(allowance >= _amount, 'Check the token allowance');
        i_usdc.transferFrom(msg.sender, address(this), _amount);
    }

    function depositDAI(uint256 _amount) external {
        s_daiBalances[msg.sender] += _amount;
        uint256 allowance = i_dai.allowance(msg.sender, address(this));
        require(allowance >= _amount, 'Check the token allowance');
        i_dai.transferFrom(msg.sender, address(this), _amount);
    }

    function buyDAI() external {
        uint256 daiToReceive = ((s_usdcBalances[msg.sender] / dexARate) * 100) *
            (10 ** 12);
        i_dai.transfer(msg.sender, daiToReceive);
    }

    function sellDAI() external {
        uint256 usdcToReceive = ((s_daiBalances[msg.sender] * dexBRate) / 100) /
            (10 ** 12);
        i_usdc.transfer(msg.sender, usdcToReceive);
    }

    function getBalance(address _tokenAddress) external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) external onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            'Only the contract owner can call this function'
        );
        _;
    }

    receive() external payable {}
}
