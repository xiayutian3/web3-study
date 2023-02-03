const hre = require("hardhat");

async function main() {

  const Token = await hre.ethers.getContractFactory("MyErc20Token");
  const token = await Token.deploy(1000);

  await token.deployed();

  console.log(
    `MyErc20Token deployed to ${token.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
