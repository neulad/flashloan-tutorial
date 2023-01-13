import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';
import { ethers } from 'hardhat';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments;
  const { deployer } = await hre.getNamedAccounts();
  const dexAddress = (await ethers.getContract('Dex')).address;

  await deploy('FlashLoanArbitrage', {
    from: deployer,
    args: [process.env.POOL_ADDRESS_PROVIDER_ADDRESS, dexAddress],
    log: true,
  });
};

export default func;
func.tags = ['all', 'flashloan-arbitrage', 'arbitrage'];
