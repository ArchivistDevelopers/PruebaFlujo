var Genesis = artifacts.require("OEGenesis");
var Token = artifacts.require("OEToken");

module.exports = function (deployer) {
    deployer.deploy(Genesis, 100, web3.utils.toWei('1', 'ether'), 1, 'https//oexperience.io/metadata/', 'OEKey', 'OEK')
        .then(function (){
           return deployer.deploy(Token, Genesis.address, 50000, 500, 5);
        });
};