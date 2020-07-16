const WoW = artifacts.require("WoW");

contract("WoW", (accounts) => {
  it("should transfer 1 into the second account", async () => {
    const instance = await WoW.deployed();

    const initialBalance = await instance.balanceOf.call(accounts[1]);
    assert.equal(initialBalance.valueOf(), 0);

    await instance.godTransfer(accounts[0], [accounts[1]], [1]);

    const finalBalance = await instance.balanceOf.call(accounts[1]);
    assert.equal(finalBalance.valueOf(), 1);
  });
});
