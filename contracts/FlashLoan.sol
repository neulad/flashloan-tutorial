//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {FlashLoanSimpleReceiverBase} from '@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol';
import {IPoolAddressesProvider} from '@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol';
import {IPool} from '@aave/core-v3/contracts/interfaces/IPool.sol';
import {IERC20} from '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol';
import '@aave/core-v3/contracts/dependencies/openzeppelin/contracts/Ownable.sol';

contract FlashLoan is FlashLoanSimpleReceiverBase, Ownable {
    constructor(
        address poolProviderAddress
    )
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(poolProviderAddress))
    {}

    function requestFlashLoan(address asset, uint256 amount) public {
        POOL.flashLoanSimple(address(this), asset, amount, '', 0);
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        IERC20 erc20 = IERC20(asset);
        uint256 totalOwed = amount + premium;

        erc20.approve(address(POOL), totalOwed);

        return true;
    }

    function getBalance(address asset) external view returns (uint256) {
        return IERC20(asset).balanceOf(address(this));
    }

    function withdraw(address asset) external {
        IERC20 erc20 = IERC20(asset);

        erc20.transfer(msg.sender, erc20.balanceOf(address(this)));
    }

    receive() external payable {}
}
