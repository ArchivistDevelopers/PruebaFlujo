require('dotenv').config();
const Genesis = artifacts.require('OEGenesis');
const Token = artifacts.require('OEToken');

const { BASE_URI } = process.env;

contract('Genesis_2/2', async(accounts) => {

  let contractGen;
  let contractTok;

  let owner = accounts[0];

  let updatedPrice;
  let supply = 0;
  let gift = 500;
  let whitelist = [
    accounts[1],
    accounts[2],
    accounts[3]
  ];

  before(async() => {
    contractGen = await Genesis.deployed();
    contractTok = await Token.deployed();
  });

    // //////////////////////// //
   // / TEST 0 - Pre-setting / //
  // //////////////////////// //
  describe('PRE-SETTING', async() => {

    it('sets ownership', async() => {
      const _owner = await contractGen.owner();

      assert.equal(owner, _owner);
    });

    it('deploys genesis successfully', () => {
      const address = contractGen.address;

      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    it('deploys token successfully', () => {
      const address = contractTok.address;

      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    it('sets token contract address', async() => {
      let tokenAddress = contractTok.address;
      await contractGen.setTokenContract(tokenAddress);
      let storedAddress = await contractGen.getTokenContract();

      assert.equal(tokenAddress, storedAddress);
    });

    it('initializes state', async() => {
      await contractGen.openMintWhitelist();
      await contractGen.openMint();

      await contractGen.setMintPrice(web3.utils.toWei('2', 'ether'));
      updatedPrice = await contractGen.getMintPrice();

      await contractGen.addToWhitelist(whitelist, 1);
      
      await contractGen.teamMint(2);
      await contractGen.mintWhitelist(1, { from: whitelist[0], value: updatedPrice });
      await contractGen.mintWhitelist(1, { from: whitelist[1], value: updatedPrice });
      await contractGen.mintWhitelist(1, { from: whitelist[2], value: updatedPrice });
      supply += 5;
    });

    it('updates control parameters', async() => {
      assert.equal(true, await contractGen.isWhitelistMintOpen());
      assert.equal(true, await contractGen.isPublicMintOpen());
    });

    it('updates whitelist minters', async() => {
      assert.equal(false, await contractGen.getWhitelist(whitelist[0]));
      assert.equal(false, await contractGen.getWhitelist(whitelist[1]));
      assert.equal(false, await contractGen.getWhitelist(whitelist[2]));
    });

    it('updates mint price', async() => {
      assert.equal(web3.utils.toWei('2', 'ether'), await contractGen.getMintPrice());
    });

    it('updates total supply', async() => {
      assert.equal(supply, await contractGen.totalSupply());
    });

    it('updates balances', async() => {
      assert.equal(2, await contractGen.balanceOf(accounts[0]));
      assert.equal(1, await contractGen.balanceOf(accounts[1]));
      assert.equal(1, await contractGen.balanceOf(accounts[2]));
      assert.equal(1, await contractGen.balanceOf(accounts[3]));
    });

  });


    // ///////////////////// //
   // / TEST 5 - Transfer / //
  // ///////////////////// //
  describe('TRANSFER', async() => {

    /*
     * Test 5.1 - Token transfer
     */
    it('transfers token - 1', async() => {
      let result = '';
      try {
        // Transfer from non owner of token ID attempt
        await contractGen.transferFrom(accounts[2], accounts[1], 4, { from: accounts[1] });
      } catch (err) {
        await contractGen.transferFrom(accounts[1], accounts[2], 3, { from: accounts[1] });
        result = 'success';
        // console.log(err);
      }
      
      assert.equal('success', result);
    });

    it('transfers token - 2', async() => {
      let result = '';
      try {
        // Transfer from non owner of token ID attempt
        await contractGen.transferFrom(accounts[0], accounts[2], 1, { from: accounts[2] });
      } catch (err) {
        await contractGen.transferFrom(accounts[0], accounts[2], 1, { from: accounts[0] });
        result = 'success';
        // console.log(err);
      }
      
      assert.equal('success', result);
    });

    /*
     * Test 5.2 - Token balance updates
     */
    it('updates token balances', async() => {
      assert.equal(1, await contractGen.balanceOf(accounts[0]));
      assert.equal(3, await contractGen.balanceOf(accounts[2]));
      assert.equal(0, await contractGen.balanceOf(accounts[1]));
    });

    /*
     * Test 5.3 - Token of owner by index update
     */
    it('updates token of owner by index', async() => {
      // First tokenId minted by accounts[2]
      assert.equal(4, await contractGen.tokenOfOwnerByIndex(accounts[2], 0));
      // Second tokenId transfered to accounts[2]
      assert.equal(3, await contractGen.tokenOfOwnerByIndex(accounts[2], 1));
      // Third tokenId transfered to accounts[2]
      assert.equal(1, await contractGen.tokenOfOwnerByIndex(accounts[2], 2));
    });

  });



    // ////////////////////// //
   // / TEST 6 - Allowance / //
  // ////////////////////// //
  describe('ALLOWANCE', async() => {

    /*
     * Test 6.1 - Grant permission to owner (approve)
     */
    it('grants one tokenId permission to owner', async() => {
      let result = '';
      await contractGen.approve(accounts[0], 4, { from: accounts[2] });
      try {
        // Transfer non approved tokenId attempt
        await contractGen.transferFrom(accounts[2], accounts[0], 3, { from: accounts[0] });
      } catch (error) {
        await contractGen.transferFrom(accounts[2], accounts[0], 4, { from: accounts[0] });
        result = 'success';
      }

        assert.equal('success', result);
        assert.equal(2, await contractGen.balanceOf(accounts[0]));
        assert.equal(2, await contractGen.balanceOf(accounts[2]));
    });

    /*
     * Test 6.2 - Grant permission to owner (setApprovalForAll)
     */
    it('grants all tokenIds permission to owner', async() => {
      await contractGen.setApprovalForAll(accounts[0], true, { from: accounts[2] });
      
      assert.equal(true, await contractGen.isApprovedForAll(accounts[2], accounts[0]));
    });

    /*
     * Test 6.3 - Transfer approved token on behalf
     */
    it('transfer approved token', async() => {
      await contractGen.transferFrom(accounts[2], accounts[0], 3, { from: accounts[0] });
      await contractGen.transferFrom(accounts[2], accounts[0], 1, { from: accounts[0] });

      assert.equal(4, await contractGen.balanceOf(accounts[0]));
      assert.equal(0, await contractGen.balanceOf(accounts[2]));
      assert.equal(3, await contractGen.tokenOfOwnerByIndex(accounts[0], 2));
      assert.equal(1, await contractGen.tokenOfOwnerByIndex(accounts[0], 3));
    });

    /*
     * Test 6.4 - Return tokens
     */
    it('returns tokens to previous owner', async() => {
      await contractGen.transferFrom(accounts[0], accounts[2], 3, { from: accounts[0] });
      await contractGen.transferFrom(accounts[0], accounts[2], 1, { from: accounts[0] });

      assert.equal(2, await contractGen.balanceOf(accounts[0]));
      assert.equal(2, await contractGen.balanceOf(accounts[2]));
    });

    /*
     * Test 6.5 - Disable approval
     */
    it('disables approval', async() => {
      await contractGen.setApprovalForAll(accounts[0], false, { from: accounts[2] });

      assert.equal(false, await contractGen.isApprovedForAll(accounts[2], accounts[0]));
    });

  });



    // /////////////////////// //
   // / TEST 7 - Withdrawal / //
  // /////////////////////// //
  describe('WITHDRAWAL', async() => {

    // Modify SC to receive ether in order to test

  });



    // ///////////////////////// //
   // / TEST 8 - Token Update / //
  // ///////////////////////// // 
  describe('TOKEN UPDATE', async() => {

    /*
     * Test 8.1 - Genesis contract address
     */
    it('set genesis contract address', async() => {
      assert.equal(contractGen.address, await contractTok.getGenesisAddress());
    });

    /*
     * Test 8.2 - OE Token balance
     */
    it('get oetoken balance', async() => {
      assert.equal(gift, await contractTok.getBalanceOE(1));
      assert.equal(gift, await contractTok.getBalanceOE(2));
      assert.equal(gift, await contractTok.getBalanceOE(3));
      assert.equal(gift, await contractTok.getBalanceOE(4));
      assert.equal(gift, await contractTok.getBalanceOE(5));
      assert.equal(0, await contractTok.getBalanceOE(6));
    });

  });



  // //////////////////////////// //
   // / TEST 9 - Visualization / //
  // ////////////////////////// // 
  describe('VISUALIZATION', async() => {


    /*
     * Test 9.1 - Metadata by tokenId query
     */
    it('returns metadata uri for tokenId', async() => {
      for(let i = 0; i < supply; i++) {
        assert.equal(`https//oexperience.io/metadata/${i + 1}.json`, await contractGen.tokenURI(i + 1));
      }
    });

    /*
     * Test 9.2 - ownership query 
     */
    it('returns the owner of tokenId', async() => {
      assert.equal(accounts[2], await contractGen.ownerOf(1));
      assert.equal(accounts[2], await contractGen.ownerOf(3));
      assert.equal(accounts[3], await contractGen.ownerOf(5));
    });

    /*
     * Test 9.3 - Key level query
     */
    it('returns key level for tokenId', async() => {
      assert.equal(1, await contractGen.getKeyLevel(1));
      assert.equal(1, await contractGen.getKeyLevel(3));

      await contractGen.setKeyLevel(5, 3);
      assert.equal(3, await contractGen.getKeyLevel(5));
    });    

  });

});


