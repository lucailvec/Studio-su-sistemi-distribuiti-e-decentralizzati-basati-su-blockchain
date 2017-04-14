var GlobalRegistrar = artifacts.require("./GlobalRegistrar.sol");

module.exports = function(deployer) {
  deployer.deploy(GlobalRegistrar);
};
