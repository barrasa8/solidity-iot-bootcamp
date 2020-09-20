const ERC20 = artifacts.require("ERC20");

contract("ERC20", async accounts => {
    it("should put 100 myCrypto in the first account",async () =>{
        let instance = await ERC20.deployed();
        let balance = await  instance.balanceOf(accounts[1]);
        assert.equal(balance.valueOf(),100);
    })
})
