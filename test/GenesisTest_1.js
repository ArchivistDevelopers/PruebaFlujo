require('dotenv').config();
const Genesis = artifacts.require('OEGenesis');
const Token = artifacts.require('OEToken');

const { OWNER, BASE_URI } = process.env;

contract('Genesis_1/2', async(accounts) => {

  let contractGen;
  let contractTok;

  let updatedPrice;
  let supply = 0;

  before(async() => {
    contractGen = await Genesis.deployed();
    contractTok = await Token.deployed();
  });


    // /////////////////////// //
   // / TEST 1 - Deployment / //
  // /////////////////////// //
  describe('DEPLOYMENT', async() => {

    /*
     * Test 1.1 - Checks for genesis contract deployment
     */
    it('deploys genesis successfully', () => {
        const address = contractGen.address;

        assert.notEqual(address, '');
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
        assert.notEqual(address, 0x0);
    });

    /*
     * Test 1.2 - Checks for token contract deployment
     */
    it('deploys token successfully', () => {
      const address = contractTok.address;

      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
      assert.notEqual(address, 0x0);
    });

    /*
     * Test 1.3 - Checks ownership
     */
    it('sets ownership', async() => {
      const owner = await contractGen.owner();

      assert.equal(owner, OWNER);
    });

    /*
     * Test 1.4 - Checks for name and symbol 
     */
    it('sets name and symbol', async() => {
        let name = await contractGen.name();
        let symbol = await contractGen.symbol();

        assert.equal('OEKey', name);
        assert.equal('OEK', symbol);
    });

    /*
     * Test 1.5 - Checks for initial mint price
     */
    it('sets initial mint price', async() => {
        let mintPrice = web3.utils.fromWei(await contractGen.getMintPrice(), 'ether');

        assert.equal(1, mintPrice);
    });

    /*
     * Test 1.6 - Checks for maximum amount per address
     */
    it('sets maximum mint', async() => {
        let maxMint = await contractGen.getMaxMint();

        assert.equal(1, maxMint);
    });

  });


    // ///////////////////// //
   // / TEST 2 - Settings / //
  // ///////////////////// //
  describe('SETTINGS', async() => {

    /*
     * Test 2.1 - Token contract address
     */
    it('sets token contract address', async() => {
      let tokenAddress = contractTok.address;
      await contractGen.setTokenContract(tokenAddress);
      let storedAddress = await contractGen.getTokenContract();

      assert.equal(tokenAddress, storedAddress);
    });

    /*
     * Test 2.2 - Supported interfaces
     */
    it('supports all compatible interfaces', async() => {
      let interfaces = ['0x80ac58cd', '0x780e9d63', '0x2a55205a'];
      for (let i = 0; i < interfaces.length; i++) {
        let result =  await contractGen.supportsInterface(interfaces[i]);

        assert.equal(true, result);
      }
    });

    /*
     * Test 2.3 - Whitelist mint settings
     */
    it('manages whitelist mint settings', async() => {
      let status = await contractGen.isWhitelistMintOpen();
      assert.equal(false, status);

      let result = '';

      try {
        await contractGen.openMintWhitelist({ from: accounts[1] });
      } catch (err) {
        await contractGen.openMintWhitelist();
        result = 'success';
        // console.log(err);
      }

      status = await contractGen.isWhitelistMintOpen();

      assert.equal('success', result);
      assert.equal(true, status)
    });

    /*
     * Test 2.4 - Public mint settings
     */
    it('manages public mint settings', async() => {
      let status = await contractGen.isPublicMintOpen();
      assert.equal(false, status);

      let result = '';

      try {
        await contractGen.openMint({ from: accounts[1] });
      } catch (err) {
        await contractGen.openMint();
        result = 'success';
        // console.log(err);
      }

      status = await contractGen.isPublicMintOpen();

      assert.equal('success', result);
      assert.equal(true, status)
    });

    /*
     * Test 2.5 - Updates mint price
     */
    it('updates mint price', async() => {
      let result = '';
      try {
        await contractGen.setMintPrice(web3.utils.toWei('2', 'ether'), { from: accounts[2] });
      } catch (err) {
        await contractGen.setMintPrice(web3.utils.toWei('2', 'ether'));
        updatedPrice = await contractGen.getMintPrice();
        result = 'success';
        // console.log(err);
      }

      assert.equal(web3.utils.toWei('2'), updatedPrice);
    });

  });




    // ////////////////////// //
   // / TEST 3 - Whitelist / //
  // ////////////////////// //
  describe('WHITELIST', async() => {

    /*
     * Test 3.1 - Whitelist inclusion
     */
    it('adds to whitelist', async() => {
        let result = '';
        let whitelisted = [
          accounts[1],
          accounts[2],
          accounts[4],
        ];
        try {
          await contractGen.addToWhitelist(whitelisted, 1, { from:accounts[1] });
        } catch (err) {
          await contractGen.addToWhitelist(whitelisted, 1);
          result = 'success';
          // console.log(err);
        }

        assert.equal('success', result);
        assert.equal(true, await contractGen.getWhitelist(accounts[1]));
        assert.equal(true, await contractGen.getWhitelist(accounts[2]));
        assert.equal(false, await contractGen.getWhitelist(accounts[3]));
        assert.equal(true, await contractGen.getWhitelist(accounts[4]));
      });

    /*
     * Test 3.2 - Whitelist removal
     */
    it('removes from whitelist', async() => {
      let result = '';
      let remove = [
        accounts[1],
        accounts[4]
      ];
      try {
        await contractGen.removeFromWhitelist(remove, { from:accounts[1] });
      } catch (err) {
        await contractGen.removeFromWhitelist(remove);
        result = 'success';
        // console.log(err);
      }

      assert.equal('success', result);
      assert.equal(false, await contractGen.getWhitelist(accounts[1]));
      assert.equal(true, await contractGen.getWhitelist(accounts[2]));
      assert.equal(false, await contractGen.getWhitelist(accounts[4]));
    });


  });




    // ///////////////// //
   // / TEST 4 - Mint / //
  // ///////////////// //
  describe('MINTING', async() => {

    let ownerBalance_prev;

    beforeEach(async() => {
      ownerBalance_prev = await web3.eth.getBalance(accounts[0]);
    });
   
    /*
     * Test 4.1 - Team mint
     */
    it('allows owner to mint in team mint', async() => {
      let result = '';
      try {
        // Non team member mint attempt
        await contractGen.teamMint(1, { from: accounts[2] });
      } catch (err) {
        try {
          // Empty team member mint attempt
          await contractGen.teamMint(0);
        } catch (err) {
          await contractGen.teamMint(3);
          result = 'success';
          supply += 3;
          // console.log(err);
        }
        // console.log(err);
      }

      assert.equal('success', result);
    });

    /*
     * Test 4.2 - Whitelist mint
     */
    it('allows whitelisted users to mint', async() => {
      let result = '';
      await contractGen.openMintWhitelist();
      try {
        // Non whitelisted user mint attempt
        await contractGen.mintWhitelist(1, { from: accounts[3], value: updatedPrice });
        result = 'fail_1';
      } catch (err) {
        try {
          // Insufficient transaction value mint attempt
          await contractGen.mintWhitelist(1, { from: accounts[2], value: web3.utils.toWei('0.5', 'ether') });
          result = 'fail_2';
        } catch (err) {
          await contractGen.mintWhitelist(1, { from: accounts[2], value: updatedPrice });
          result = 'success';
          supply += 1;
          // console.log(err);
        }
        // console.log(err);
      }

      assert.equal('success', result);
    });

    /*
     * Test 4.3 - Whitelist auto transfer
     */
    it('transfer funds directly to owner after whitelist mint', async() => {
      let whitelisted = [ accounts[4] ];
      await contractGen.addToWhitelist(whitelisted, 1);
      await contractGen.mintWhitelist(1, { from: accounts[4], value: updatedPrice });
      supply += 1;
      let ownerBalance_aft = await web3.eth.getBalance(accounts[0]);

      // Must account for gas consumption
      assert(ownerBalance_aft - ownerBalance_prev > web3.utils.toWei('1.9', 'ether'));
    });

    /*
     * Test 4.4 - Public mint
     */
    it('allows public mint', async() => {
      let result = '';
      await contractGen.openMint();
      try {
        // Number of minted tokens over limit attempt
        await contractGen.mint(2, { from: accounts[3], value: updatedPrice });
        result = 'fail_1';
      } catch (err) {
        try {
          // Insufficient transaction value attempt
          await contractGen.mint(1, { from: accounts[3], value: web3.utils.toWei('0.5', 'ether') });
          result = 'fail_2';
        } catch (err) {
          await contractGen.mint(1, { from: accounts[3], value: updatedPrice });
          result = 'success';
          supply += 1;
          // console.log(err);
        }
        // console.log(err);
      }

      assert.equal('success', result);
    });

    /*
     * Test 4.5 - Public auto transfer
     */
    it('transfer funds directly to owner after public mint', async() => {
      await contractGen.mint(1, { from: accounts[5], value: updatedPrice });
      supply += 1;
      let ownerBalance_aft = await web3.eth.getBalance(accounts[0]);

      // Must account for gas consumption
      assert(ownerBalance_aft - ownerBalance_prev > web3.utils.toWei('1.9', 'ether'));
    });

    /*
     * Test 4.6 - Public mint pausing
     */
    it('blocks public minting when paused', async() => {
      let result = '';
      await contractGen.pauseMint();
      try {
        // Non owner (balance: 0) mint while paused attempt
        await contractGen.mint(1, { from: accounts[6], value: updatedPrice });
      } catch (err) {
        result = 'success';
        // console.log(err);
      }

      assert.equal('success', result);
    });

    /*
     * Test 4.7 - Restricted balance per address
     */
    it('restricts the maximum balance per address', async() => {
      let result = '';
      await contractGen.openMint();
      try {
        // Already owner (balance > 0) mint attempt
        await contractGen.mint(1, { from: accounts[5], value: updatedPrice });
      } catch (err) {
        result = 'success';
        // console.log(err);
      }

      assert.equal('success', result);
    });
    
    /*
     * Test 4.8 - Token of owner by index
     */
    it('tracks token of owner by index', async() => {
      await contractGen.teamMint(1);
      supply += 1;

      assert.equal(1, await contractGen.tokenOfOwnerByIndex(accounts[0], 0));
      assert.equal(2, await contractGen.tokenOfOwnerByIndex(accounts[0], 1));
      assert.equal(3, await contractGen.tokenOfOwnerByIndex(accounts[0], 2));
      assert.equal(supply - 1, await contractGen.tokenOfOwnerByIndex(accounts[5], 0));
      assert.equal(supply, await contractGen.tokenOfOwnerByIndex(accounts[0], 3));
    });

    /*
     * Test 4.9 - Token by index
     */
    it('tracks token by index', async() => {
      for(let i = 0; i < supply; i++) {
        assert.equal(i+1, await contractGen.tokenByIndex(i));
      }
    });

    /*
     * Test 4.10 - Total supply
     */
    it('tracks total supply', async() => {
      assert.equal(supply, await contractGen.totalSupply());
    });

  });

});