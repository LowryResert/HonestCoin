const HonestCoin = artifacts.require("HonestCoin");

module.exports = function (deployer) {
  deployer.deploy(HonestCoin, 10000, "HonestCoin", "HNC");
};
