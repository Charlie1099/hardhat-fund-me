
require('hardhat-deploy');
require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config();
require("@nomiclabs/hardhat-etherscan")
require("hardhat-gas-reporter")
require("solidity-coverage")
require("@nomiclabs/hardhat-ethers")
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.8",
};
