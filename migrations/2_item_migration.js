const Item = artifacts.require("Item");
const ItemManager = artifacts.require("ItemManager")

module.exports = async function (deployer) {
  await deployer.deploy(ItemManager)
  const itemManager = await ItemManager.deployed()
  await deployer.deploy(Item, itemManager.address, "1000000000", 0);
};
