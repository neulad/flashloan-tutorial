<!-- ABOUT THE PROJECT -->
## About The Project
*This project was created for fun for learning purposes, never use it on production, it's raw and not tested at all!*

Here I implemented a flashloan arbitrafe strategy against mocked dex contract. I followed [this](https://www.youtube.com/watch?v=PtMs8FZJhkU) tutorial. I've rewritten in in typescript an have added some solidity improvments as long as script to run all steps.

<!-- GETTING STARTED -->
## Getting Started

Just grab everything to the console, no environmental variables needed!

### Prerequisites

I hope you've installed node.js already)
* npm
  ```sh
  npm install npm@latest -g
  ```
* hardhat-shorthand
  ```sh
  npm i -g hardhat-shorthand
  ```

### Installation

1. Clone the repo
   ```sh
   git clone git@github.com:neulad/flashloan-tutorial.git
   ```
2. Install dependencies
   ```sh
   npm install
   ```
3. Add .env file with the following variables
   ```sh
   GOERLI_RPC_URL=CHANGE_ME
   PRIVATE_KEY=CHANGE_ME
   POOL_ADDRESS_PROVIDER_ADDRESS=CHANGE_ME
   DAI_ADDRESS=CHANGE_ME
   USDC_ADDRESS=CHANGE_ME
   ```
4. Add USDC and DAI from AAVE [list](https://docs.aave.com/developers/deployed-contracts/v3-testnet-addresses) of contracts to your wallet, 
   then get some balance on your wallet using uniswap so that script can transfer some balance on the DEX contract to initiate the pool
5. Now run the script :)   
   ```sh
   hh run ./scripts/fullArbitrageSteps.ts --network goerli
   ```

<!-- USAGE EXAMPLES -->
## Usage
Congrats!!!!
Now you should see the message that arbitrage is fulfilled


