// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGenesis {

    /*
     * {OEGenesis} - Verifies Genesis members
     */
    function isGenesis(address addr) external view returns(bool);

    /*
     * {OEGenesis} - Verifies tokenId existence
     */
    function verifyTokenId(uint256 tokenId) external view returns(bool);

    /*
     * {OEGenesis} - Initializes Genesis membership 
     */
    function initializeGenesisMembership(uint256 tokenId) external;

    /*
     * {OEGenesis} - Returns tokenId Key level
     */
    function getKeyLevel(uint256 tokenId) external view returns(uint256);

}
