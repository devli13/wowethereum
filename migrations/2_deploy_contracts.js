const WoW = artifacts.require("WoW");

module.exports = function(deployer) {
  deployer.deploy(WoW);
};
