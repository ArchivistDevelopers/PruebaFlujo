# Entertainment-smart-contracts

## Components
- **Genesis** -> custom ERC-721 that can only be purchased by members of a whitelist. This ERC-721 is the key to accessing the ecosystem's applications and can evolve to higher levels, changing its appearance (metadata) and benefits (purchaseable experiences, token yielding rate, exclusive offers, etc.) depending on the participation in the community.
- **Main Experience** -> custom ERC-721 that only genesis members can buy. It presents tiers depending on genesis level. These are personalized exclusive experiences.
- **Club options** -> custom ERC-721 which can only be acquired by genesis members, but can be traded or exchanged on secondary markets (Opensea). These are seasoned organized experiences.
- **Art&Collectibles** - > custom ERC-721 token that can be purchased by those who had redeemed their NFT from Main Experience and Club Options
- **OE token** -> Custom fungible token that could be purchased on the marketplace with ETH or USDC or through yielding, by holding a Genesis token. This token enables Club Options and Art&Collectibles purchases to the community. The price of the token is constant regarding USDC and the ETH rate is adjusted with an oracle.
- **Treasury** -> Smart Contract where Genesis members can make proposals about the future of the community. In this SC funds can be deposited to make investments, share experiences, vote for future events or develop the ecosystem.

## Code Structure
For this project, Archivist proposed different architectures in order to find the most suitable solution:
### First Proposal
In this first proposal, 6 contracts linked by 2 interfaces are deployed:
- **IOEToken**: OE token interface which has built-in functions to update the amount of OE tokens held by a user when the user acquires or uses the tokens.
- **IGenesis** : interface that allows only genesis members to access the functionalities of the rest of the components. Furthermore, it checks the level of Genesis token to give access to higher level functionalities.

In addition, Archivist made a proposal by studying the business case where the OE tokens purchased by participants could also be used as treasury funds.This is represented by the yellow dotted line linking the OE token contract to the treasury. This proposal will be repeated in the other suggested architectures, as a method for incentivizing the token utility and demand.

**Pros** | **Cons**
--- | --- 
Increased security through distributed balances among SCs | Less blockchain efficent (+cost, +time)
Increased security through segmentation of contracts and interfaces| More expensive communication between Scs
Opensea compatible| Higher front-end complexity
  &nbsp; | Higher cost on deployment (6 deploys)

![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v1.png?raw=true)
### Second Proposal
3 contracts and one interface are deployed in this architecture. The Main Experience contract inherits the functionalities of the Club options contract (both share many functionalities) and in turn, the Genesis inherits the functionalities of the Main Experience and Art&Collectibles contracts. The interface will include de functionalities to check the genesis members and to update the balance of the token

**Pros** | **Cons**
--- | --- 
More blockchain efficent (-cost, -time) | No compatible with Opensea
Cheap in the communication between SCs| Less secure due to more centralize balances
Less complexity in front-end| 
Low cost on deploy (3 deploys) | 

![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v2.png?raw=true)
### Third Proposal
In this last proposal, 4 contracts will be deployed and the genesis contract will inherit the functionalities of the OE token and the Main Experience and Club Options contracts will be grouped into one contract. There would only be one interface to check the genesis membership.

**Pros** | **Cons**
--- | --- 
More secure than V2|  Less secure than V1
More blockchain eficient than V1| Less blockchain eficient than V2
Less front-end complexity than V1| More front-end complexity than V2
Less cost on deploy than V1 | More cost on deploy than V2
Opensea compatible|

![alt text](https://github.com/ArchivistDevelopers/Entertainment-smart-contracts/blob/main/Dependencies_v3.png?raw=true)



































