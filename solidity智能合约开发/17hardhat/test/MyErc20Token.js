const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("MyErc20Token", function () {

  async function deployOneYearLockFixture() {

    const totalSupply = 1 * 10**8;
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("MyErc20Token");
    const token = await Token.deploy(totalSupply);

    return { token, totalSupply, owner, otherAccount };
  }

  describe("Deployment", function () {
    it(" totalSupply number", async function () {
      const { token, totalSupply } = await loadFixture(deployOneYearLockFixture);

      expect(await token.totalSupply()).to.equal(totalSupply);
    });

    it("transfer", async function () {
      const { token } = await loadFixture(deployOneYearLockFixture);
      await token.transfer('0x459d27569c287C3EbF54773430F1D09555f191Ab',1000);
      expect(await token.balanceOf('0x459d27569c287C3EbF54773430F1D09555f191Ab')).to.equal(1000);
    });

    it("mint", async function () {
      const { token, otherAccount } = await loadFixture(deployOneYearLockFixture);
      await token.connect(otherAccount).mintToByEther({value: 1000});
      expect(await token.balanceOf(otherAccount.address)).to.equal(1000);
    });

  });

});
