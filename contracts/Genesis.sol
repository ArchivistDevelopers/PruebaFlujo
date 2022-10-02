// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token/ERC721.sol";
import "./token/extensions/ERC721Enumerable.sol";
import "./utils/Ownable.sol";
import "./utils/Address.sol";
import "./utils/Strings.sol";
import "./interfaces/IGenesis.sol";
import "./token/ERC2981.sol";



contract OEGenesis is ERC721, ERC721Enumerable, ERC2981, Ownable {

    using Address for address;
    using Strings for uint256;

    // States if Public Sale is open
    bool private activePublicSale;

    // States if Whitelist Sale is open
    bool private activeWhitelistSale;

    // Maps whitelisted addresses with maximum tokens allowed to mint
    mapping(address => uint8) private _whiteList;

    // Base URI for OE Genesis token metadata
    string private baseURI;

    // Maximum number of tokens allowed per address
    uint256 private MAX_MINT;

    // Maximum OE Genesis token supply 
    uint256 private MAX_SUPPLY;

    // OE Genesis mint price
    uint256 private PRICE_MINT;

    // OEToken contract
    IGenesis OEToken;

    // OE KEY Level - Token ID to Key Level
    mapping(uint256 => uint256) private keyLevel;


    constructor(uint256 maxSupply, uint256 mintPrice, uint256 maxMint, string memory BaseURI, string memory name, string memory symbol) 
        ERC721(name, symbol) 
    {
        activePublicSale = false;
        activeWhitelistSale = false;

        MAX_MINT = maxMint;
        MAX_SUPPLY = maxSupply; 
        PRICE_MINT = mintPrice;

        baseURI = BaseURI;
    }



    /*
     * {IERC165} - Checks compatibility with inherited standard interfaces
     */
    function supportsInterface(bytes4 interfaceId) public view
        override(ERC721, ERC721Enumerable, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /*
     * {OEGenesis} - Returns true if input address is Genesis 
     */
    function isGenesis(address addr) external view returns(bool) {
        return _isGenesis(addr);
    }

    
    /*
     * {OEGenesis} - Returns true if tokenId exists
     */  
    function verifyTokenId(uint256 tokenId) external view returns(bool) {
        return _exists(tokenId);
    }
    

    /*
     * {OEGenesis} - Sets the OEToken contract address
     */
    function setTokenContract(address tokenAddress) external onlyOwner {
        OEToken = IGenesis(tokenAddress);
    }




    /*
     * {OEGenesis} - Returns token URI after token is minted
     */
    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory currentBaseURI = _baseURI();
    
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), ".json"))
            : "";
    }

    /*
     * {OEGenesis} - Returns metadata base URI 
     */
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    /*
     * {OEGenesis} - Updates metadata base URI
     */
    function updateBaseURI(string memory baseURI_) external onlyOwner {
        baseURI = baseURI_;
    }

    


    /*
     * {OEGenesis} - Team mint for OE Genesis
     */
    function teamMint(uint8 numToMint) external onlyOwner {
        uint256 Id = totalSupply();
        require(numToMint > 0, "OE GENESIS: number of tokens must be higher than zero");
        require(Id + numToMint <= MAX_SUPPLY, "OE GENESIS: max supply reached");

        for(uint i = 1; i <= numToMint; i++) {
            _safeMint(msg.sender, Id + i);
            keyLevel[Id + i] = 1;
            OEToken.initializeGenesisMembership(Id + i);
        }
    }

    /*
     * {OEGenesis} - Adds new addresses to the Whitelist
     */
    function addToWhitelist(address[] calldata addresses, uint8 numAllowedToMint) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            _whiteList[addresses[i]] = numAllowedToMint;
        }
    }

    /*
     * {OEGenesis} - Removes addresses from the Whitelist
     */
    function removeFromWhitelist(address[] calldata addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            _whiteList[addresses[i]] = 0;
        }
    }

    /*
     * {OEGenesis} - Returns true if address is (still) whitelisted
     */
    function getWhitelist(address addr) public view returns(bool) {
        if(_whiteList[addr] > 0) return true;
        else return false;
    }

    /*
     * {OEGenesis} - Whitelist mint for OE Genesis 
     */
    function mintWhitelist(uint8 numToMint) external payable {
        require(!msg.sender.isContract(), "OE GENESIS: Address should be an EOA");
        uint256 Id = totalSupply();
        uint256 txValue = msg.value;
        require(numToMint > 0, "OE GENESIS: number of tokens must be higher than zero");
        require(isWhitelistMintOpen(), "OE GENESIS: the sale is currently closed");
        require(Id + numToMint <= MAX_SUPPLY, "OE GENESIS: max supply reached");
        require(numToMint <= _whiteList[msg.sender], "OE GENESIS: token amount per transaction is resctricted");
        require(getMintPrice() * numToMint <= txValue, "OE GENESIS: value of the transaction insufficient");
        
        _whiteList[msg.sender] -= numToMint;

        for(uint i = 1; i <= numToMint; i++) {
            _safeMint(msg.sender, Id + i);
            keyLevel[Id + i] = 1;
            OEToken.initializeGenesisMembership(Id + i);
        }

        _transferToOwner(txValue);
    }

    /*
     * {OEGenesis} - Returns true if whitelist mint is open
     */
    function isWhitelistMintOpen() public view returns(bool) {
        return activeWhitelistSale;
    }

    /*
     * {OEGenesis} - Allows owner to open the whitelist mint
     */
    function openMintWhitelist() external onlyOwner {
        activeWhitelistSale = true;
    }

    /*
     * {OEGenesis} - Allows owner to pause the whitelist mint
     */
    function pauseMintWhitelist() external onlyOwner {
        activeWhitelistSale = false;
    }



   
    /*
     * {OEGenesis} - Public mint for OE Genesis
     */
    function mint(uint8 numToMint) external payable {
        require(!msg.sender.isContract(), "OE GENESIS: Address should be an EOA");
        uint256 Id = totalSupply(); 
        uint256 txValue = msg.value;
        require(numToMint > 0, "OE GENESIS: number of tokens must be higher than zero");
        require(isPublicMintOpen(), "OE GENESIS: the sale is currently closed");
        require(Id + numToMint <= MAX_SUPPLY, "OE GENESIS: max supply reached");
        require(numToMint <= MAX_MINT, "OE GENESIS: mint restricted to 1 token");
        require(balanceOf(msg.sender) < MAX_MINT, "OE GENESIS: this address is already Genesis");
        require(getMintPrice() * numToMint <= txValue, "OE GENESIS: value of the transaction insufficient");
        
        for(uint i = 1; i <= numToMint; i++) {
            _safeMint(msg.sender, Id + i);
            keyLevel[Id + i] = 1;
            OEToken.initializeGenesisMembership(Id + i);
        }

        _transferToOwner(txValue);
    }

    /*
     * {OEGenesis} - Returns true if public mint is open
     */
    function isPublicMintOpen() public view returns(bool) {
        return activePublicSale;
    }

    /*
     * {OEGenesis} - Allows owner to open the public mint
     */
    function openMint() external onlyOwner {
        activePublicSale = true;
    }

    /*
     * {OEGenesis} - Allows owner to pause the public mint
     */
    function pauseMint() external onlyOwner {
        activePublicSale = false;
    }



    /*
     * {OEGenesis} - Returns mint price
     */
    function getMintPrice() public view returns(uint256) {
        return PRICE_MINT;
    }

    /*
     * {OEGenesis} - Allows owner to set mint price
     */
    function setMintPrice(uint256 mintPrice) external onlyOwner {
        PRICE_MINT = mintPrice;
    }




    /*
     * {OEGenesis} - Returns OE Key level for tokenId
     */
    function getKeyLevel(uint256 tokenId) public view returns(uint256) {
        require(_exists(tokenId), "OE GENESIS: query for non-existent token");
        return keyLevel[tokenId];
    }

    /*
     * {OEGenesis} - Allows owner to set OE Key level for tokenId
     */
    function setKeyLevel(uint256 tokenId, uint256 tokenLevel) external onlyOwner {
        require(_exists(tokenId), "OE GENESIS: query for non-existent token");
        keyLevel[tokenId] = tokenLevel;
    }




    /*
     * {OEGenesis} - Allows owner to set default royalties for secondary sales
     */
    function setDefaultRoyalty(address receiver, uint96 feeNumerator) public onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }



    /*
     * {OEGenesis} - Allows any contract balance withdrawal
     */
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }
    
    /*
     * {OEGenesis} - Transfers input funds to owner address
     */
    function _transferToOwner(uint256 txValue) internal {
        uint balance = txValue;
        payable(owner()).transfer(balance);
    }

    


    /*
     * {ERC721, ERC721Enumerable} - Adds functionality to Enumerable extension
     */
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /*
     * {OEGenesis} - Returns true if input address is Genesis
     */
    function _isGenesis(address _addr) private view returns(bool) {
        uint256 balance = balanceOf(_addr);
        if(balance > 0) {
            return true;
        } else return false;
    }

}

