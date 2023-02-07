const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("MyErc721Token", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployTokenFixture() {
    const totalSupply = 1*10**8

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount,a1, a2, a3] = await ethers.getSigners();
    // console.log('owner, otherAccount,a1, a2, a3: ', owner, otherAccount,a1, a2, a3);

    const Token = await ethers.getContractFactory("MyNFT");
    const token = await Token.deploy();

    return { token, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("mint", async function () {
      const { token, owner } = await loadFixture(deployTokenFixture);
      let url = "https://com.images/1" //图片地址,
      await token.mint(url); //开始铸造nft
       url = "https://com.images/2" //图片地址,
      await token.mint(url); //开始铸造nft
      url = "https://com.images/3" //图片地址,
      await token.mint(url); //开始铸造nft

      const balanceOf = await token.balanceOf(owner.address)
      for(let i=0; i<balanceOf;i++){
        let tokenId = await token.tokenOfOwnerByIndex(owner.address,i);
        let tokenUri = await token.tokenURI(tokenId);
        console.log('tokenUri: ', tokenUri);
      }

      // const tokenOwner = await token.ownerOf(0)
      // let murl = await token.tokenURI(0)
      // const balanceOf = await token.balanceOf(tokenOwner)

      expect(balanceOf).to.equal(3);
    });
  });
});
