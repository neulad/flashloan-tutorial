import { ethers, getNamedAccounts } from 'hardhat';
import { FlashLoanArbitrage, IERC20 } from '../typechain-types';

async function main() {
  const { deployer } = await getNamedAccounts();

  const dex = await ethers.getContract('Dex');
  const flashloanArbitrage = await ethers.getContract<FlashLoanArbitrage>(
    'FlashLoanArbitrage'
  );
  const dai = await ethers.getContractAt<IERC20>(
    'IERC20',
    process.env.DAI_ADDRESS || ''
  );
  const usdc = await ethers.getContractAt<IERC20>(
    'IERC20',
    process.env.USDC_ADDRESS || ''
  );

  // 10 USDC to cover interest
  const usdcBalance = await usdc.balanceOf(dex.address);
  if (usdcBalance.lt('10000000')) await usdc.transfer(dex.address, '10000000');

  // 10 DAI to cover interest
  const daiBalance = await dai.balanceOf(dex.address);
  if (daiBalance.lt('10000000000000000000'))
    await dai.transfer(dex.address, '10000000000000000000');

  // Request 5 USDC
  await flashloanArbitrage.requestFlashLoan(usdc.address, '5000000');
}

main()
  .then(() => {
    console.log(`Arbitrage is successfully performed! 👏`);
    process.exit(0);
  })
  .catch((err) => {
    console.error(`⚠️ Error occured: ${err.message}!`);
    process.exit(1);
  });
