// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface IOEToken {

    /*
     * {OEGenesis} - Updates OE Key tokenId balance of OE Token 
     */
    function updateBalance(uint256 amount, uint256 tokenId) external;

    /*
     * {OEGenesis} - Returns OE Token balance for OE Key tokenId
     */
    function getBalanceOE(uint256 tokenId) external returns(uint256);

}