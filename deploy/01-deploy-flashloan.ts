import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deploy } = hre.deployments;
  const { deployer } = await hre.getNamedAccounts();

  await deploy('FlashLoan', {
    from: deployer,
    args: [process.env.POOL_ADDRESS_PROVIDER_ADDRESS],
    log: true,
  });
};

export default func;
func.tags = ['all', 'flashloan'];
