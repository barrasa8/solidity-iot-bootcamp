const ERC20 = artifacts.require("ERC20");

module.exports = function(deployer,network,accounts) {
  deployer.deploy(ERC20,"myContract","MC").then(function(instance){
    instance.mint(accounts[1],100,{from: accounts[0]}).then(function(){
        console.log("SUCCESS")
    })
  }).catch(function(err){
    console.log("Error:" +err)
  });
}