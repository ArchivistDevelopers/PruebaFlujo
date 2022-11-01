Timers.isPending(Timers.Timestamp) (utils/Timer.sol#34-36) uses timestamp for comparisons
        Dangerous comparisons:
        - timer._deadline > block.timestamp (utils/Timer.sol#35)
Timers.isExpired(Timers.Timestamp) (utils/Timer.sol#38-40) uses timestamp for comparisons
        Dangerous comparisons:
        - isStarted(timer) && timer._deadline <= block.timestamp (utils/Timer.sol#39)
OEToken.harvestYield(uint256) (OEToken.sol#320-341) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,string)(amount > 0,OEToken: not enough tokens to yield) (OEToken.sol#332-335)
OEToken._setInitialBalance(uint256) (OEToken.sol#349-358) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,string)(OEBank.bankBalance >= welcomeGift,OEToken: insufficient OE Bank balance) (OEToken.sol#350-353)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp

Address.verifyCallResult(bool,bytes,string) (utils/Address.sol#201-221) uses assembly
        - INLINE ASM (utils/Address.sol#213-216)
ERC721._checkOnERC721Received(address,address,uint256,bytes) (token/ERC721.sol#389-410) uses assembly
        - INLINE ASM (token/ERC721.sol#402-404)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage

Different versions of Solidity are used:
        - Version used: ['>=0.4.22<0.9.0', '^0.8.0']
        - ^0.8.0 (interfaces/IOEToken.sol#2)
        - ^0.8.0 (interfaces/standard/IERC165.sol#5)
        - ^0.8.0 (interfaces/standard/IERC2981.sol#4)
        - ^0.8.0 (interfaces/standard/IERC721Receiver.sol#4)
        - ^0.8.0 (@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#2)
        - ^0.8.0 (utils/Timer.sol#4)
        - ^0.8.0 (token/extensions/ERC721Enumerable.sol#4)
        - ^0.8.0 (token/ERC165.sol#3)
        - ^0.8.0 (Genesis.sol#2)
        - ^0.8.0 (utils/Address.sol#4)
        - ^0.8.0 (token/ERC721.sol#4)
        - ^0.8.0 (interfaces/standard/IERC721Metadata.sol#4)
        - ^0.8.0 (utils/Context.sol#4)
        - ^0.8.0 (utils/Strings.sol#4)
        - ^0.8.0 (token/ERC2981.sol#4)
        - >=0.4.22<0.9.0 (Migrations.sol#2)
        - ^0.8.0 (interfaces/standard/IERC721.sol#4)
        - ^0.8.0 (interfaces/standard/IERC721Enumerable.sol#4)
        - ^0.8.0 (utils/Ownable.sol#4)
        - ^0.8.0 (interfaces/standard/IERC20.sol#4)
        - ^0.8.0 (interfaces/IGenesis.sol#2)
        - ^0.8.0 (OEToken.sol#2)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used

ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256) (token/extensions/ERC721Enumerable.sol#144-162) has costly operations inside a loop:
        - delete _allTokensIndex[tokenId] (token/extensions/ERC721Enumerable.sol#160)
ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256) (token/extensions/ERC721Enumerable.sol#144-162) has costly operations inside a loop:
        - _allTokens.pop() (token/extensions/ERC721Enumerable.sol#161)
ERC721Enumerable._removeTokenFromOwnerEnumeration(address,uint256) (token/extensions/ERC721Enumerable.sol#119-137) has costly operations inside a loop:
        - delete _ownedTokensIndex[tokenId] (token/extensions/ERC721Enumerable.sol#135)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#costly-operations-inside-a-loop

Address.functionCall(address,bytes) (utils/Address.sol#85-87) is never used and should be removed
Address.functionCall(address,bytes,string) (utils/Address.sol#95-101) is never used and should be removed
Address.functionCallWithValue(address,bytes,uint256) (utils/Address.sol#114-120) is never used and should be removed
Address.functionCallWithValue(address,bytes,uint256,string) (utils/Address.sol#128-139) is never used and should be removed
Address.functionDelegateCall(address,bytes) (utils/Address.sol#174-176) is never used and should be removed
Address.functionDelegateCall(address,bytes,string) (utils/Address.sol#184-193) is never used and should be removed
Address.functionStaticCall(address,bytes) (utils/Address.sol#147-149) is never used and should be removed
Address.functionStaticCall(address,bytes,string) (utils/Address.sol#157-166) is never used and should be removed
Address.sendValue(address,uint256) (utils/Address.sol#60-65) is never used and should be removed
Address.verifyCallResult(bool,bytes,string) (utils/Address.sol#201-221) is never used and should be removed
Context._msgData() (utils/Context.sol#21-23) is never used and should be removed
ERC2981._deleteDefaultRoyalty() (token/ERC2981.sol#82-84) is never used and should be removed
ERC2981._resetTokenRoyalty(uint256) (token/ERC2981.sol#109-111) is never used and should be removed
ERC2981._setTokenRoyalty(uint256,address,uint96) (token/ERC2981.sol#95-104) is never used and should be removed
ERC721._baseURI() (token/ERC721.sol#106-108) is never used and should be removed
ERC721._burn(uint256) (token/ERC721.sol#305-319) is never used and should be removed
Strings.toHexString(uint256) (utils/Strings.sol#40-51) is never used and should be removed
Strings.toHexString(uint256,uint256) (utils/Strings.sol#56-66) is never used and should be removed
Timers.getDeadline(Timers.BlockNumber) (utils/Timer.sol#46-48) is never used and should be removed
Timers.getDeadline(Timers.Timestamp) (utils/Timer.sol#14-16) is never used and should be removed
Timers.isExpired(Timers.BlockNumber) (utils/Timer.sol#70-72) is never used and should be removed
Timers.isExpired(Timers.Timestamp) (utils/Timer.sol#38-40) is never used and should be removed
Timers.isPending(Timers.BlockNumber) (utils/Timer.sol#66-68) is never used and should be removed
Timers.isPending(Timers.Timestamp) (utils/Timer.sol#34-36) is never used and should be removed
Timers.isStarted(Timers.BlockNumber) (utils/Timer.sol#62-64) is never used and should be removed
Timers.isStarted(Timers.Timestamp) (utils/Timer.sol#30-32) is never used and should be removed
Timers.isUnset(Timers.BlockNumber) (utils/Timer.sol#58-60) is never used and should be removed
Timers.isUnset(Timers.Timestamp) (utils/Timer.sol#26-28) is never used and should be removed
Timers.reset(Timers.BlockNumber) (utils/Timer.sol#54-56) is never used and should be removed
Timers.reset(Timers.Timestamp) (utils/Timer.sol#22-24) is never used and should be removed
Timers.setDeadline(Timers.BlockNumber,uint64) (utils/Timer.sol#50-52) is never used and should be removed
Timers.setDeadline(Timers.Timestamp,uint64) (utils/Timer.sol#18-20) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code

Pragma version^0.8.0 (interfaces/IOEToken.sol#2) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC165.sol#5) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC2981.sol#4) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC721Receiver.sol#4) allows old versions
Pragma version^0.8.0 (@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#2) allows old versions
Pragma version^0.8.0 (utils/Timer.sol#4) allows old versions
Pragma version^0.8.0 (token/extensions/ERC721Enumerable.sol#4) allows old versions
Pragma version^0.8.0 (token/ERC165.sol#3) allows old versions
Pragma version^0.8.0 (Genesis.sol#2) allows old versions
Pragma version^0.8.0 (utils/Address.sol#4) allows old versions
Pragma version^0.8.0 (token/ERC721.sol#4) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC721Metadata.sol#4) allows old versions
Pragma version^0.8.0 (utils/Context.sol#4) allows old versions
Pragma version^0.8.0 (utils/Strings.sol#4) allows old versions
Pragma version^0.8.0 (token/ERC2981.sol#4) allows old versions
Pragma version>=0.4.22<0.9.0 (Migrations.sol#2) is too complex
Pragma version^0.8.0 (interfaces/standard/IERC721.sol#4) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC721Enumerable.sol#4) allows old versions
Pragma version^0.8.0 (utils/Ownable.sol#4) allows old versions
Pragma version^0.8.0 (interfaces/standard/IERC20.sol#4) allows old versions
Pragma version^0.8.0 (interfaces/IGenesis.sol#2) allows old versions
Pragma version^0.8.0 (OEToken.sol#2) allows old versions
solc-0.8.17 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity

Low level call in Address.sendValue(address,uint256) (utils/Address.sol#60-65):
        - (success) = recipient.call{value: amount}() (utils/Address.sol#63)
Low level call in Address.functionCallWithValue(address,bytes,uint256,string) (utils/Address.sol#128-139):
        - (success,returndata) = target.call{value: value}(data) (utils/Address.sol#137)
Low level call in Address.functionStaticCall(address,bytes,string) (utils/Address.sol#157-166):
        - (success,returndata) = target.staticcall(data) (utils/Address.sol#164)
Low level call in Address.functionDelegateCall(address,bytes,string) (utils/Address.sol#184-193):
        - (success,returndata) = target.delegatecall(data) (utils/Address.sol#191)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls

Variable OEGenesis.MAX_MINT (Genesis.sol#31) is not in mixedCase
Variable OEGenesis.MAX_SUPPLY (Genesis.sol#34) is not in mixedCase
Variable OEGenesis.PRICE_MINT (Genesis.sol#37) is not in mixedCase
Variable OEGenesis.OEToken (Genesis.sol#40) is not in mixedCase
Parameter ERC721.safeTransferFrom(address,address,uint256,bytes)._data (token/ERC721.sol#180) is not in mixedCase
Parameter ERC2981.royaltyInfo(uint256,uint256)._tokenId (token/ERC2981.sol#43) is not in mixedCase
Parameter ERC2981.royaltyInfo(uint256,uint256)._salePrice (token/ERC2981.sol#43) is not in mixedCase
Parameter Migrations.upgrade(address).new_address (Migrations.sol#20) is not in mixedCase
Variable Migrations.last_completed_migration (Migrations.sol#6) is not in mixedCase
Struct OEToken.OE_KeyHolder (OEToken.sol#27-32) is not in CapWords
Struct OEToken.OE_Bank (OEToken.sol#39-42) is not in CapWords
Function OEToken.ETHUSDrate() (OEToken.sol#373-376) is not in mixedCase
Variable OEToken.USDC_token (OEToken.sol#16) is not in mixedCase
Variable OEToken.GenesisContract (OEToken.sol#22) is not in mixedCase
Variable OEToken.MainExperience (OEToken.sol#23) is not in mixedCase
Variable OEToken.ClubOptions (OEToken.sol#24) is not in mixedCase
Variable OEToken.OEKeyHolder (OEToken.sol#35) is not in mixedCase
Variable OEToken.OEBank (OEToken.sol#45) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions

OEToken.oracleFeed (OEToken.sol#20) should be constant
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-constant
Summary
 - [unchecked-transfer](#unchecked-transfer) (2 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (1 results) (Medium)
 - [unused-return](#unused-return) (1 results) (Medium)
 - [shadowing-local](#shadowing-local) (2 results) (Low)
 - [events-maths](#events-maths) (2 results) (Low)
 - [calls-loop](#calls-loop) (4 results) (Low)
 - [variable-scope](#variable-scope) (3 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (4 results) (Low)
 - [timestamp](#timestamp) (4 results) (Low)
 - [assembly](#assembly) (2 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [costly-loop](#costly-loop) (3 results) (Informational)
 - [dead-code](#dead-code) (32 results) (Informational)
 - [solc-version](#solc-version) (23 results) (Informational)
 - [low-level-calls](#low-level-calls) (4 results) (Informational)
 - [naming-convention](#naming-convention) (18 results) (Informational)
 - [constable-states](#constable-states) (1 results) (Optimization)
## unchecked-transfer
Impact: High
Confidence: Medium
 - [ ] ID-0
[OEToken.withdraw()](contracts/OEToken.sol#L385-L390) ignores return value by [USDC_token.transferFrom(address(this),msg.sender,balanceUSDC)](contracts/OEToken.sol#L389)

contracts/OEToken.sol#L385-L390


 - [ ] ID-1
[OEToken.buyOETokensWithUSDC(uint256,uint256)](contracts/OEToken.sol#L243-L260) ignores return value by [USDC_token.transferFrom(msg.sender,address(this),price)](contracts/OEToken.sol#L256)

contracts/OEToken.sol#L243-L260


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-2
[OEToken.getYield(uint256)](contracts/OEToken.sol#L309-L314) performs a multiplication on the result of a division:
        - [multiplier = period / 86400](contracts/OEToken.sol#L311)
        - [result = (OEKeyHolder[tokenId].yieldRate) * multiplier](contracts/OEToken.sol#L312)

contracts/OEToken.sol#L309-L314


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-3
[ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) ignores return value by [IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,_data)](contracts/token/ERC721.sol#L396-L406)

contracts/token/ERC721.sol#L389-L410


## shadowing-local
Impact: Low
Confidence: High
 - [ ] ID-4
[OEGenesis.constructor(uint256,uint256,uint256,string,string,string).name](contracts/Genesis.sol#L46) shadows:
        - [ERC721.name()](contracts/token/ERC721.sol#L80-L82) (function)
        - [IERC721Metadata.name()](contracts/interfaces/standard/IERC721Metadata.sol#L16) (function)

contracts/Genesis.sol#L46


 - [ ] ID-5
[OEGenesis.constructor(uint256,uint256,uint256,string,string,string).symbol](contracts/Genesis.sol#L46) shadows:
        - [ERC721.symbol()](contracts/token/ERC721.sol#L87-L89) (function)
        - [IERC721Metadata.symbol()](contracts/interfaces/standard/IERC721Metadata.sol#L21) (function)

contracts/Genesis.sol#L46


## events-maths
Impact: Low
Confidence: Medium
 - [ ] ID-6
[OEToken.setWelcomeGift(uint256)](contracts/OEToken.sol#L138-L140) should emit an event for: 
        - [welcomeGift = newWelcomeGift](contracts/OEToken.sol#L139) 

contracts/OEToken.sol#L138-L140


 - [ ] ID-7
[OEGenesis.setMintPrice(uint256)](contracts/Genesis.sol#L295-L297) should emit an event for: 
        - [PRICE_MINT = mintPrice](contracts/Genesis.sol#L296) 

contracts/Genesis.sol#L295-L297


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-8
[OEGenesis.teamMint(uint8)](contracts/Genesis.sol#L140-L156) has external calls inside a loop: [OEToken.initializeGenesisMembership(Id + i)](contracts/Genesis.sol#L154)

contracts/Genesis.sol#L140-L156


 - [ ] ID-9
[ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) has external calls inside a loop: [IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,_data)](contracts/token/ERC721.sol#L396-L406)

contracts/token/ERC721.sol#L389-L410


 - [ ] ID-10
[OEGenesis.mintWhitelist(uint8)](contracts/Genesis.sol#L187-L206) has external calls inside a loop: [OEToken.initializeGenesisMembership(Id + i)](contracts/Genesis.sol#L202)

contracts/Genesis.sol#L187-L206


 - [ ] ID-11
[OEGenesis.mint(uint8)](contracts/Genesis.sol#L235-L253) has external calls inside a loop: [OEToken.initializeGenesisMembership(Id + i)](contracts/Genesis.sol#L249)

contracts/Genesis.sol#L235-L253


## variable-scope
Impact: Low
Confidence: High
 - [ ] ID-12
Variable '[ERC721._checkOnERC721Received(address,address,uint256,bytes).reason](contracts/token/ERC721.sol#L398)' in [ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) potentially used before declaration: [reason.length == 0](contracts/token/ERC721.sol#L399)

contracts/token/ERC721.sol#L398


 - [ ] ID-13
Variable '[ERC721._checkOnERC721Received(address,address,uint256,bytes).retval](contracts/token/ERC721.sol#L396)' in [ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) potentially used before declaration: [retval == IERC721Receiver.onERC721Received.selector](contracts/token/ERC721.sol#L397)

contracts/token/ERC721.sol#L396


 - [ ] ID-14
Variable '[ERC721._checkOnERC721Received(address,address,uint256,bytes).reason](contracts/token/ERC721.sol#L398)' in [ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) potentially used before declaration: [revert(uint256,uint256)(32 + reason,mload(uint256)(reason))](contracts/token/ERC721.sol#L403)

contracts/token/ERC721.sol#L398


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-15
Reentrancy in [OEToken.buyOETokensWithUSDC(uint256,uint256)](contracts/OEToken.sol#L243-L260):
        External calls:
        - [USDC_token.transferFrom(msg.sender,address(this),price)](contracts/OEToken.sol#L256)
        State variables written after the call(s):
        - [OEBank.bankBalance -= amount](contracts/OEToken.sol#L258)
        - [OEKeyHolder[tokenId].balanceOE += amount](contracts/OEToken.sol#L259)

contracts/OEToken.sol#L243-L260


 - [ ] ID-16
Reentrancy in [OEGenesis.teamMint(uint8)](contracts/Genesis.sol#L140-L156):
        External calls:
        - [_safeMint(msg.sender,Id + i)](contracts/Genesis.sol#L152)
                - [IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,_data)](contracts/token/ERC721.sol#L396-L406)
        State variables written after the call(s):
        - [keyLevel[Id + i] = 1](contracts/Genesis.sol#L153)

contracts/Genesis.sol#L140-L156


 - [ ] ID-17
Reentrancy in [OEGenesis.mintWhitelist(uint8)](contracts/Genesis.sol#L187-L206):
        External calls:
        - [_safeMint(msg.sender,Id + i)](contracts/Genesis.sol#L200)
                - [IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,_data)](contracts/token/ERC721.sol#L396-L406)
        State variables written after the call(s):
        - [keyLevel[Id + i] = 1](contracts/Genesis.sol#L201)

contracts/Genesis.sol#L187-L206


 - [ ] ID-18
Reentrancy in [OEGenesis.mint(uint8)](contracts/Genesis.sol#L235-L253):
        External calls:
        - [_safeMint(msg.sender,Id + i)](contracts/Genesis.sol#L247)
                - [IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,_data)](contracts/token/ERC721.sol#L396-L406)
        State variables written after the call(s):
        - [keyLevel[Id + i] = 1](contracts/Genesis.sol#L248)

contracts/Genesis.sol#L235-L253


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-19
[Timers.isPending(Timers.Timestamp)](contracts/utils/Timer.sol#L34-L36) uses timestamp for comparisons
        Dangerous comparisons:
        - [timer._deadline > block.timestamp](contracts/utils/Timer.sol#L35)

contracts/utils/Timer.sol#L34-L36


 - [ ] ID-20
[OEToken.harvestYield(uint256)](contracts/OEToken.sol#L320-L341) uses timestamp for comparisons
        Dangerous comparisons:
        - [require(bool,string)(amount > 0,OEToken: not enough tokens to yield)](contracts/OEToken.sol#L332-L335)

contracts/OEToken.sol#L320-L341


 - [ ] ID-21
[OEToken._setInitialBalance(uint256)](contracts/OEToken.sol#L349-L358) uses timestamp for comparisons
        Dangerous comparisons:
        - [require(bool,string)(OEBank.bankBalance >= welcomeGift,OEToken: insufficient OE Bank balance)](contracts/OEToken.sol#L350-L353)

contracts/OEToken.sol#L349-L358


 - [ ] ID-22
[Timers.isExpired(Timers.Timestamp)](contracts/utils/Timer.sol#L38-L40) uses timestamp for comparisons
        Dangerous comparisons:
        - [isStarted(timer) && timer._deadline <= block.timestamp](contracts/utils/Timer.sol#L39)

contracts/utils/Timer.sol#L38-L40


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-23
[Address.verifyCallResult(bool,bytes,string)](contracts/utils/Address.sol#L201-L221) uses assembly
        - [INLINE ASM](contracts/utils/Address.sol#L213-L216)

contracts/utils/Address.sol#L201-L221


 - [ ] ID-24
[ERC721._checkOnERC721Received(address,address,uint256,bytes)](contracts/token/ERC721.sol#L389-L410) uses assembly
        - [INLINE ASM](contracts/token/ERC721.sol#L402-L404)

contracts/token/ERC721.sol#L389-L410


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-25
Different versions of Solidity are used:
        - Version used: ['>=0.4.22<0.9.0', '^0.8.0']
        - [^0.8.0](contracts/interfaces/IOEToken.sol#L2)
        - [^0.8.0](contracts/interfaces/standard/IERC165.sol#L5)
        - [^0.8.0](contracts/interfaces/standard/IERC2981.sol#L4)
        - [^0.8.0](contracts/interfaces/standard/IERC721Receiver.sol#L4)
        - [^0.8.0](node_modules/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2)
        - [^0.8.0](contracts/utils/Timer.sol#L4)
        - [^0.8.0](contracts/token/extensions/ERC721Enumerable.sol#L4)
        - [^0.8.0](contracts/token/ERC165.sol#L3)
        - [^0.8.0](contracts/Genesis.sol#L2)
        - [^0.8.0](contracts/utils/Address.sol#L4)
        - [^0.8.0](contracts/token/ERC721.sol#L4)
        - [^0.8.0](contracts/interfaces/standard/IERC721Metadata.sol#L4)
        - [^0.8.0](contracts/utils/Context.sol#L4)
        - [^0.8.0](contracts/utils/Strings.sol#L4)
        - [^0.8.0](contracts/token/ERC2981.sol#L4)
        - [>=0.4.22<0.9.0](contracts/Migrations.sol#L2)
        - [^0.8.0](contracts/interfaces/standard/IERC721.sol#L4)
        - [^0.8.0](contracts/interfaces/standard/IERC721Enumerable.sol#L4)
        - [^0.8.0](contracts/utils/Ownable.sol#L4)
        - [^0.8.0](contracts/interfaces/standard/IERC20.sol#L4)
        - [^0.8.0](contracts/interfaces/IGenesis.sol#L2)
        - [^0.8.0](contracts/OEToken.sol#L2)

contracts/interfaces/IOEToken.sol#L2


## costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-26
[ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256)](contracts/token/extensions/ERC721Enumerable.sol#L144-L162) has costly operations inside a loop:
        - [delete _allTokensIndex[tokenId]](contracts/token/extensions/ERC721Enumerable.sol#L160)

contracts/token/extensions/ERC721Enumerable.sol#L144-L162


 - [ ] ID-27
[ERC721Enumerable._removeTokenFromOwnerEnumeration(address,uint256)](contracts/token/extensions/ERC721Enumerable.sol#L119-L137) has costly operations inside a loop:
        - [delete _ownedTokensIndex[tokenId]](contracts/token/extensions/ERC721Enumerable.sol#L135)

contracts/token/extensions/ERC721Enumerable.sol#L119-L137


 - [ ] ID-28
[ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256)](contracts/token/extensions/ERC721Enumerable.sol#L144-L162) has costly operations inside a loop:
        - [_allTokens.pop()](contracts/token/extensions/ERC721Enumerable.sol#L161)

contracts/token/extensions/ERC721Enumerable.sol#L144-L162


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-29
[Address.verifyCallResult(bool,bytes,string)](contracts/utils/Address.sol#L201-L221) is never used and should be removed

contracts/utils/Address.sol#L201-L221


 - [ ] ID-30
[Strings.toHexString(uint256,uint256)](contracts/utils/Strings.sol#L56-L66) is never used and should be removed

contracts/utils/Strings.sol#L56-L66


 - [ ] ID-31
[Address.sendValue(address,uint256)](contracts/utils/Address.sol#L60-L65) is never used and should be removed

contracts/utils/Address.sol#L60-L65


 - [ ] ID-32
[Address.functionCallWithValue(address,bytes,uint256)](contracts/utils/Address.sol#L114-L120) is never used and should be removed

contracts/utils/Address.sol#L114-L120


 - [ ] ID-33
[ERC2981._setTokenRoyalty(uint256,address,uint96)](contracts/token/ERC2981.sol#L95-L104) is never used and should be removed

contracts/token/ERC2981.sol#L95-L104


 - [ ] ID-34
[Timers.isPending(Timers.Timestamp)](contracts/utils/Timer.sol#L34-L36) is never used and should be removed

contracts/utils/Timer.sol#L34-L36


 - [ ] ID-35
[Address.functionDelegateCall(address,bytes,string)](contracts/utils/Address.sol#L184-L193) is never used and should be removed

contracts/utils/Address.sol#L184-L193


 - [ ] ID-36
[Timers.isExpired(Timers.BlockNumber)](contracts/utils/Timer.sol#L70-L72) is never used and should be removed

contracts/utils/Timer.sol#L70-L72


 - [ ] ID-37
[Timers.reset(Timers.Timestamp)](contracts/utils/Timer.sol#L22-L24) is never used and should be removed

contracts/utils/Timer.sol#L22-L24


 - [ ] ID-38
[Strings.toHexString(uint256)](contracts/utils/Strings.sol#L40-L51) is never used and should be removed

contracts/utils/Strings.sol#L40-L51


 - [ ] ID-39
[ERC721._burn(uint256)](contracts/token/ERC721.sol#L305-L319) is never used and should be removed

contracts/token/ERC721.sol#L305-L319


 - [ ] ID-40
[Address.functionDelegateCall(address,bytes)](contracts/utils/Address.sol#L174-L176) is never used and should be removed

contracts/utils/Address.sol#L174-L176


 - [ ] ID-41
[Timers.getDeadline(Timers.Timestamp)](contracts/utils/Timer.sol#L14-L16) is never used and should be removed

contracts/utils/Timer.sol#L14-L16


 - [ ] ID-42
[Timers.reset(Timers.BlockNumber)](contracts/utils/Timer.sol#L54-L56) is never used and should be removed

contracts/utils/Timer.sol#L54-L56


 - [ ] ID-43
[Timers.isPending(Timers.BlockNumber)](contracts/utils/Timer.sol#L66-L68) is never used and should be removed

contracts/utils/Timer.sol#L66-L68


 - [ ] ID-44
[Timers.setDeadline(Timers.BlockNumber,uint64)](contracts/utils/Timer.sol#L50-L52) is never used and should be removed

contracts/utils/Timer.sol#L50-L52


 - [ ] ID-45
[Timers.setDeadline(Timers.Timestamp,uint64)](contracts/utils/Timer.sol#L18-L20) is never used and should be removed

contracts/utils/Timer.sol#L18-L20


 - [ ] ID-46
[Address.functionCallWithValue(address,bytes,uint256,string)](contracts/utils/Address.sol#L128-L139) is never used and should be removed

contracts/utils/Address.sol#L128-L139


 - [ ] ID-47
[Timers.isExpired(Timers.Timestamp)](contracts/utils/Timer.sol#L38-L40) is never used and should be removed

contracts/utils/Timer.sol#L38-L40


 - [ ] ID-48
[ERC2981._deleteDefaultRoyalty()](contracts/token/ERC2981.sol#L82-L84) is never used and should be removed

contracts/token/ERC2981.sol#L82-L84


 - [ ] ID-49
[Context._msgData()](contracts/utils/Context.sol#L21-L23) is never used and should be removed

contracts/utils/Context.sol#L21-L23


 - [ ] ID-50
[Address.functionStaticCall(address,bytes)](contracts/utils/Address.sol#L147-L149) is never used and should be removed

contracts/utils/Address.sol#L147-L149


 - [ ] ID-51
[Timers.isUnset(Timers.BlockNumber)](contracts/utils/Timer.sol#L58-L60) is never used and should be removed

contracts/utils/Timer.sol#L58-L60


 - [ ] ID-52
[Timers.getDeadline(Timers.BlockNumber)](contracts/utils/Timer.sol#L46-L48) is never used and should be removed

contracts/utils/Timer.sol#L46-L48


 - [ ] ID-53
[Timers.isStarted(Timers.Timestamp)](contracts/utils/Timer.sol#L30-L32) is never used and should be removed

contracts/utils/Timer.sol#L30-L32


 - [ ] ID-54
[ERC721._baseURI()](contracts/token/ERC721.sol#L106-L108) is never used and should be removed

contracts/token/ERC721.sol#L106-L108


 - [ ] ID-55
[ERC2981._resetTokenRoyalty(uint256)](contracts/token/ERC2981.sol#L109-L111) is never used and should be removed

contracts/token/ERC2981.sol#L109-L111


 - [ ] ID-56
[Timers.isStarted(Timers.BlockNumber)](contracts/utils/Timer.sol#L62-L64) is never used and should be removed

contracts/utils/Timer.sol#L62-L64


 - [ ] ID-57
[Address.functionCall(address,bytes,string)](contracts/utils/Address.sol#L95-L101) is never used and should be removed

contracts/utils/Address.sol#L95-L101


 - [ ] ID-58
[Timers.isUnset(Timers.Timestamp)](contracts/utils/Timer.sol#L26-L28) is never used and should be removed

contracts/utils/Timer.sol#L26-L28


 - [ ] ID-59
[Address.functionStaticCall(address,bytes,string)](contracts/utils/Address.sol#L157-L166) is never used and should be removed

contracts/utils/Address.sol#L157-L166


 - [ ] ID-60
[Address.functionCall(address,bytes)](contracts/utils/Address.sol#L85-L87) is never used and should be removed

contracts/utils/Address.sol#L85-L87


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-61
Pragma version[^0.8.0](contracts/interfaces/standard/IERC20.sol#L4) allows old versions

contracts/interfaces/standard/IERC20.sol#L4


 - [ ] ID-62
Pragma version[^0.8.0](contracts/token/extensions/ERC721Enumerable.sol#L4) allows old versions

contracts/token/extensions/ERC721Enumerable.sol#L4


 - [ ] ID-63
Pragma version[^0.8.0](contracts/token/ERC721.sol#L4) allows old versions

contracts/token/ERC721.sol#L4


 - [ ] ID-64
Pragma version[^0.8.0](contracts/interfaces/standard/IERC165.sol#L5) allows old versions

contracts/interfaces/standard/IERC165.sol#L5


 - [ ] ID-65
Pragma version[^0.8.0](contracts/token/ERC165.sol#L3) allows old versions

contracts/token/ERC165.sol#L3


 - [ ] ID-66
Pragma version[^0.8.0](contracts/interfaces/standard/IERC721.sol#L4) allows old versions

contracts/interfaces/standard/IERC721.sol#L4


 - [ ] ID-67
Pragma version[^0.8.0](contracts/OEToken.sol#L2) allows old versions

contracts/OEToken.sol#L2


 - [ ] ID-68
Pragma version[^0.8.0](contracts/utils/Context.sol#L4) allows old versions

contracts/utils/Context.sol#L4


 - [ ] ID-69
Pragma version[^0.8.0](contracts/utils/Address.sol#L4) allows old versions

contracts/utils/Address.sol#L4


 - [ ] ID-70
Pragma version[^0.8.0](contracts/interfaces/IGenesis.sol#L2) allows old versions

contracts/interfaces/IGenesis.sol#L2


 - [ ] ID-71
Pragma version[^0.8.0](contracts/Genesis.sol#L2) allows old versions

contracts/Genesis.sol#L2


 - [ ] ID-72
Pragma version[^0.8.0](contracts/token/ERC2981.sol#L4) allows old versions

contracts/token/ERC2981.sol#L4


 - [ ] ID-73
Pragma version[^0.8.0](node_modules/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2) allows old versions

node_modules/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol#L2


 - [ ] ID-74
solc-0.8.17 is not recommended for deployment

 - [ ] ID-75
Pragma version[^0.8.0](contracts/interfaces/standard/IERC721Receiver.sol#L4) allows old versions

contracts/interfaces/standard/IERC721Receiver.sol#L4


 - [ ] ID-76
Pragma version[^0.8.0](contracts/utils/Strings.sol#L4) allows old versions

contracts/utils/Strings.sol#L4


 - [ ] ID-77
Pragma version[^0.8.0](contracts/interfaces/IOEToken.sol#L2) allows old versions

contracts/interfaces/IOEToken.sol#L2


 - [ ] ID-78
Pragma version[^0.8.0](contracts/interfaces/standard/IERC721Enumerable.sol#L4) allows old versions

contracts/interfaces/standard/IERC721Enumerable.sol#L4


 - [ ] ID-79
Pragma version[^0.8.0](contracts/utils/Timer.sol#L4) allows old versions

contracts/utils/Timer.sol#L4


 - [ ] ID-80
Pragma version[^0.8.0](contracts/interfaces/standard/IERC721Metadata.sol#L4) allows old versions

contracts/interfaces/standard/IERC721Metadata.sol#L4


 - [ ] ID-81
Pragma version[^0.8.0](contracts/utils/Ownable.sol#L4) allows old versions

contracts/utils/Ownable.sol#L4


 - [ ] ID-82
Pragma version[^0.8.0](contracts/interfaces/standard/IERC2981.sol#L4) allows old versions

contracts/interfaces/standard/IERC2981.sol#L4


 - [ ] ID-83
Pragma version[>=0.4.22<0.9.0](contracts/Migrations.sol#L2) is too complex

contracts/Migrations.sol#L2


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-84
Low level call in [Address.functionDelegateCall(address,bytes,string)](contracts/utils/Address.sol#L184-L193):
        - [(success,returndata) = target.delegatecall(data)](contracts/utils/Address.sol#L191)

contracts/utils/Address.sol#L184-L193


 - [ ] ID-85
Low level call in [Address.sendValue(address,uint256)](contracts/utils/Address.sol#L60-L65):
        - [(success) = recipient.call{value: amount}()](contracts/utils/Address.sol#L63)

contracts/utils/Address.sol#L60-L65


 - [ ] ID-86
Low level call in [Address.functionStaticCall(address,bytes,string)](contracts/utils/Address.sol#L157-L166):
        - [(success,returndata) = target.staticcall(data)](contracts/utils/Address.sol#L164)

contracts/utils/Address.sol#L157-L166


 - [ ] ID-87
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](contracts/utils/Address.sol#L128-L139):
        - [(success,returndata) = target.call{value: value}(data)](contracts/utils/Address.sol#L137)

contracts/utils/Address.sol#L128-L139


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-88
Struct [OEToken.OE_KeyHolder](contracts/OEToken.sol#L27-L32) is not in CapWords

contracts/OEToken.sol#L27-L32


 - [ ] ID-89
Variable [OEGenesis.MAX_MINT](contracts/Genesis.sol#L31) is not in mixedCase

contracts/Genesis.sol#L31


 - [ ] ID-90
Variable [Migrations.last_completed_migration](contracts/Migrations.sol#L6) is not in mixedCase

contracts/Migrations.sol#L6


 - [ ] ID-91
Variable [OEToken.OEBank](contracts/OEToken.sol#L45) is not in mixedCase

contracts/OEToken.sol#L45


 - [ ] ID-92
Variable [OEGenesis.PRICE_MINT](contracts/Genesis.sol#L37) is not in mixedCase

contracts/Genesis.sol#L37


 - [ ] ID-93
Parameter [ERC721.safeTransferFrom(address,address,uint256,bytes)._data](contracts/token/ERC721.sol#L180) is not in mixedCase

contracts/token/ERC721.sol#L180


 - [ ] ID-94
Struct [OEToken.OE_Bank](contracts/OEToken.sol#L39-L42) is not in CapWords

contracts/OEToken.sol#L39-L42


 - [ ] ID-95
Parameter [Migrations.upgrade(address).new_address](contracts/Migrations.sol#L20) is not in mixedCase

contracts/Migrations.sol#L20


 - [ ] ID-96
Variable [OEToken.OEKeyHolder](contracts/OEToken.sol#L35) is not in mixedCase

contracts/OEToken.sol#L35


 - [ ] ID-97
Parameter [ERC2981.royaltyInfo(uint256,uint256)._tokenId](contracts/token/ERC2981.sol#L43) is not in mixedCase

contracts/token/ERC2981.sol#L43


 - [ ] ID-98
Function [OEToken.ETHUSDrate()](contracts/OEToken.sol#L373-L376) is not in mixedCase

contracts/OEToken.sol#L373-L376


 - [ ] ID-99
Variable [OEGenesis.OEToken](contracts/Genesis.sol#L40) is not in mixedCase

contracts/Genesis.sol#L40


 - [ ] ID-100
Parameter [ERC2981.royaltyInfo(uint256,uint256)._salePrice](contracts/token/ERC2981.sol#L43) is not in mixedCase

contracts/token/ERC2981.sol#L43


 - [ ] ID-101
Variable [OEToken.MainExperience](contracts/OEToken.sol#L23) is not in mixedCase

contracts/OEToken.sol#L23


 - [ ] ID-102
Variable [OEToken.GenesisContract](contracts/OEToken.sol#L22) is not in mixedCase

contracts/OEToken.sol#L22


 - [ ] ID-103
Variable [OEGenesis.MAX_SUPPLY](contracts/Genesis.sol#L34) is not in mixedCase

contracts/Genesis.sol#L34


 - [ ] ID-104
Variable [OEToken.ClubOptions](contracts/OEToken.sol#L24) is not in mixedCase

contracts/OEToken.sol#L24


 - [ ] ID-105
Variable [OEToken.USDC_token](contracts/OEToken.sol#L16) is not in mixedCase

contracts/OEToken.sol#L16


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-106
[OEToken.oracleFeed](contracts/OEToken.sol#L20) should be constant

contracts/OEToken.sol#L20


. analyzed (22 contracts with 81 detectors), 107 result(s) found
