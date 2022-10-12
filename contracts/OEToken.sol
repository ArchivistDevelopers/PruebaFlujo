// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/Address.sol";
import "./utils/Ownable.sol";
import "./interfaces/IGenesis.sol";
import "./interfaces/standard/IERC20.sol";
import "./interfaces/IOEToken.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract OEToken is Ownable {

    using Address for address;

    IERC20 USDC_token;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    AggregatorV3Interface internal priceFeed;
    address oracleFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;

    IGenesis public GenesisContract;
    IOEToken public MainExperience;
    IOEToken public ClubOptions;

    // OE Key data
    struct OE_KeyHolder {
        uint256 timestamp;
        uint256 yieldRate; 
        uint256 totalYielded;
        uint256 balanceOE;
    }

    // Token ID => Key Holder
    mapping(uint256 => OE_KeyHolder) private OEKeyHolder;


    // Balance of the OE Bank
    struct OE_Bank {
        uint256 currentSupply;
        uint256 bankBalance;
    }

    // OE Bank 
    OE_Bank private OEBank;

    // Initial token allocation
    uint256 private welcomeGift;

    // OE KEY Level => Yield Rate
    mapping(uint8 => uint256) private _yieldRates;

    // OEToken price in USD
    uint256 public priceUSD;


    
    constructor(address genesisAddress, uint256 initialSupply, uint256 _welcomeGift, uint256 _priceUSD) {
        GenesisContract = IGenesis(genesisAddress);
        USDC_token = IERC20(USDC);
        priceFeed = AggregatorV3Interface(oracleFeed);
        
        OEBank.currentSupply = initialSupply;
        OEBank.bankBalance = initialSupply;

        welcomeGift = _welcomeGift;
        priceUSD = _priceUSD;
    }



    /*
     * {OEToken} - Sets new Genesis contract address
     */
    function setNewGenesisAddress(address contractAddress) external onlyOwner {
        require(contractAddress.isContract(), "OEToken: address is not contract address");
        GenesisContract = IGenesis(contractAddress);
    }

    /*
     * {OEToken} - Sets Main Experience contract address
     */
    function setMainExperienceAddress(address contractAddress) external onlyOwner {
        require(contractAddress.isContract(), "OEToken: address is not contract address");
        MainExperience = IOEToken(contractAddress);
    }

    /*
     * {OEToken} - Sets Club Options contract address
     */
    function setClubOptionsAddress(address contractAddress) external onlyOwner {
        require(contractAddress.isContract(), "OEToken: address is not contract address");
        ClubOptions = IOEToken(contractAddress);
    }



    /*
     * {OEToken} - Gets Genesis contract address
     */
    function getGenesisAddress() public view returns(address) {
        return address(GenesisContract);
    }

    /*
     * {OEToken} - Gets MainExperience contract address
     */
    function getMainExperienceAddress() public view returns(address) {
        return address(MainExperience);
    }

    /*
     * {OEToken} - Gets ClubOptions contract address
     */
    function getClubOptionsAddress() public view returns(address) {
        return address(ClubOptions);
    }



    /*
     * {OEToken} - Returns Genesis Membership welcome gift
     */
    function getWelcomeGift() public view returns(uint256) {
        return welcomeGift;
    }

    /*
     * {OEToken} - Returns OE Token yield rate by OEKey level
     */
    function getYieldRate(uint8 keyLevel) public view returns(uint256) {
        return _yieldRates[keyLevel];
    }

    /*
     * {OEToken} - Sets Genesis Membership welcome gift
     */
    function setWelcomeGift(uint256 newWelcomeGift) external onlyOwner {
        welcomeGift = newWelcomeGift;
    }

   /*
    * {OEToken} - Set yield rates
    */
    function setYieldRates(uint8[] calldata level, uint256[] calldata rate) external onlyOwner {
        for(uint8 i = 0; i < level.length; i++) {
            _yieldRates[i] = rate[i];
        }
    }

    /*
    * {OEToken} - Set OEToken price in USD
    */
    function setOETokenPrice(uint256 newPrice) external onlyOwner {
        require(
            newPrice > 0,
            "OEToken: invalid price"
        );

        priceUSD = newPrice;
    }




    /*
     * {OEToken} - Allows owner to increase utility OEToken supply
     *
     * OEToken is not a tradeable token, supply does not affect token value
     */
    function mintOETokens(uint256 amount) external onlyOwner {
        OEBank.currentSupply += amount;
        OEBank.bankBalance += amount;
    }

    /*
     * {OEToken} - Allows owner to transfer tokens to tokenId
     */
    function transferTokens(uint256 amount, uint256 tokenId) public onlyOwner {
        require(
            GenesisContract.verifyTokenId(tokenId),
            "OEGenesis: non-existing tokenId"
        );

        OEBank.bankBalance -= amount;
        OEKeyHolder[tokenId].balanceOE += amount;
    }





    /*
     * {OEToken} - Returns OEToken balance for tokenId
     */
    function getBalanceOE(uint256 tokenId) external view returns(uint256) {
        return OEKeyHolder[tokenId].balanceOE;
    }

    /*
     * {OEToken} - Returns current supply for OEToken
     */
    function getCurrentSupply() external view returns(uint256) {
        return OEBank.currentSupply;
    }

    /*
     * {OEToken} - Returns current OE Bank balance of OEToken
     */
    function getBankBalance() external view returns(uint256) {
        return OEBank.bankBalance;
    }




    /*
     * {OEToken} - Allows OE Genesis Member to purchase OEToken with ETH
     */
    function buyOETokensWithETH(uint tokenId, int amount) public payable {
        require(
            msg.sender == GenesisContract.ownerOf(tokenId), 
            "OEGenesis: caller is not tokenId owner"
        );

        int usdPrice = amount * int(priceUSD) * (10 ** 18); // Total price in USD
        int ethusdRate = ETHUSDrate() * (10 ** 10); // Price in USD * 10^18
        int weiPrice = usdPrice * (10 ** 18) / ethusdRate; // Amount to spend in wei

        require(
            int(msg.value) >= weiPrice,
            "OEToken: Insufficient funds"
        );

        _transferToOwner(msg.value);
    }

    /*
     * {OEToken} - Allows OE Genesis Member to purchase OEToken with USDC
     *
     * OEToken/USD constant rate
     */
    function buyOETokensWithUSDC(uint256 tokenId, uint256 amount) public {
        require(
            msg.sender == GenesisContract.ownerOf(tokenId),
            "OEGenesis: caller is not tokenId owner"
        );
        
        uint256 price = amount * priceUSD * (10 ** 6);

        require(
            USDC_token.allowance(msg.sender, address(this)) >= price,
            "OEToken: Insufficient allowance amount"
        );

        USDC_token.transferFrom(msg.sender, address(this), price);

        OEBank.bankBalance -= amount;
        OEKeyHolder[tokenId].balanceOE += amount;
    }



   
    /*
     * {OEToken} - Sets initial state of OE Genesis Membership and begins yielding
     */
    function initializeGenesisMembership(uint256 tokenId) external {
        require(
            msg.sender == address(GenesisContract),
            "OEToken: Unexpected caller"
        );
        require( 
            OEKeyHolder[tokenId].timestamp == 0,
            "Main Experience: Token ID already initialized"
        );

        _setInitialBalance(tokenId);
        _initializeYield(tokenId);
    }


    /*
     * {OEToken} - Externally updates OEToken balance of tokenID when spending
     */
    function updateSpendedBalance(uint256 amount, uint256 tokenId) external {
        require(
            msg.sender == address(MainExperience) || msg.sender == address(ClubOptions),
            "OEToken: Unexpected caller"
        );
        require(
            GenesisContract.verifyTokenId(tokenId),
            "OEGenesis: non-existing tokenID"
        );
        require(
            OEKeyHolder[tokenId].balanceOE >= amount,
            "OEToken: Insufficient balance for this operation"
        );

        OEKeyHolder[tokenId].balanceOE -= amount;
        OEBank.bankBalance += amount;
    }



    /*
     * {OEToken} - Returns current amount of yielded OEToken by tokenId
     */
    function getYield(uint256 tokenId) public view returns(uint256) {
        uint256 period = (block.timestamp) - (OEKeyHolder[tokenId].timestamp);
        uint256 multiplier = period / 86400;
        uint256 result = (OEKeyHolder[tokenId].yieldRate) * multiplier;
        return result;
    }


    /*
     * {OEToken} - Allows tokenId owner to harvest yielded OEToken
     */
    function harvestYield(uint256 tokenId) external {
        require(
            GenesisContract.verifyTokenId(tokenId), 
            "OEGenesis: non-existing tokenID"
        );
        require(
            GenesisContract.ownerOf(tokenId) == msg.sender,
            "OEGenesis: caller is not tokenId owner"
        );

        uint256 amount = getYield(tokenId);

        require(
            amount > 0,
            "OEToken: not enough tokens to yield"
        );
        
        OEKeyHolder[tokenId].balanceOE += amount;
        OEBank.currentSupply += amount;

        OEKeyHolder[tokenId].timestamp = block.timestamp;
    }




    /*
     * {OEToken} - Set initial Genesis Membership token balance
     */
    function _setInitialBalance(uint256 tokenId) internal {
        require(
            OEBank.bankBalance >= welcomeGift,
            "OEToken: insufficient OE Bank balance"
        );


        OEBank.bankBalance -= welcomeGift;
        OEKeyHolder[tokenId].balanceOE += welcomeGift;
    }
   
    /*
     * {OEToken} - Sets initial token yielding parameters
     */
    function _initializeYield(uint256 tokenId) internal {
        OEKeyHolder[tokenId].timestamp = block.timestamp;
        OEKeyHolder[tokenId].yieldRate = _yieldRates[1];
    }



    /*
     * {OEToken} - Returns ETH/USD rate
     */
    function ETHUSDrate() internal view returns (int) {
        ( ,int price, , , ) = priceFeed.latestRoundData();
        return price;
    }





    /*
     * {OEToken} - Allows any contract balance withdrawal
     */
    function withdraw() public onlyOwner {
        uint balanceETH = address(this).balance;
        uint balanceUSDC = USDC_token.balanceOf(address(this));
        if (balanceETH > 0) payable(msg.sender).transfer(balanceETH);
        if (balanceUSDC > 0) USDC_token.transferFrom(address(this), msg.sender, balanceUSDC);
    }
    
    /*
     * {OEToken} - Transfers input funds to owner address
     */
    function _transferToOwner(uint256 txValue) internal {
        uint balance = txValue;
        payable(owner()).transfer(balance);
    }


}