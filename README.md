# Entertainment-smart-contracts

## Components
- **Genesis** -> custom ERC-721 that could only be purchased by members of a whitelist. This ERC-721 could evolve to higher levels changing its appearance depending on the participation in the community.
- **Main Experience** -> custom ERC-721 that only genesis members could buy. It has tiers depending on genesis level
- **Club options** ->ERC-721 customised which could only be acquired by genesis members, but could be sold on secondary markets (Opensea)
- **Art&Collectibles** - >ERC-721 custom token that could be purchased by those who had redeemed their NFT from Main Experience and club options
- **OE token** -> Custom token that could be purchased on the marketplace or by yielding the Genesis. With this token you could buy Club Options or Art&Collectibles. The price of this token is linked to the price of the dollar through an oracle.
- **Treasury** -> Smart Contract where Genesis members could make proposals about the future of the community. In this SC funds could be deposited to make investments.

## Code Structure
For this project, Archivist proposed different architectures in order to find the most suitable solution:
### First Proposal
In this first proposal, 6 contracts linked by 2 interfaces would be deployed:
- **IOEToken**: OE token interface which has built-in functions to update the amount of OE tokens held by a user when the user acquires or uses the tokens.
- **IGenesis** : interface that will allow only genesis members to access the functionalities of the rest of the components. Furthermore, it checks the level of the Genesis to give access to higher level functionalities.

In addition, Archivist made a proposal by studying the business case where the EO tokens purchased by participants could also be used as treasury funds.This is represented by the yellow dotted line linking the OE token contract to the treasury.This proposal will be repeated in the other suggested architectures.

**Pros** | **Cons**
--- | --- 
Increased security through distributed balances | Less efficent (+cost, +time)
Increased security through segmentation of contracts and interfaces| More expensive the communication between Scs
Opensea compatible| More complexity in front-end
| High cost on deploy ( 6 deploys)

![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v1.png?raw=true)
### Second Proposal


![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v2.png?raw=true)
### Third Proposal
![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v3.png?raw=true)



































