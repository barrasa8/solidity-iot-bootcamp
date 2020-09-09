pragma solidity 0.5.12;
import './People.sol';

contract Workers is People{

    mapping (address=>uint) public salary;
    mapping (address=>address) public workersBoss;
    
    function  createWorker(string memory name, uint age, uint height,uint workerSalary,address workerAddress, address bossAddress) public onlyOwner  payable costs(100 wei) {
        require(age<=75);
        require(msg.value >= 100 wei);
        createPerson(name, age, height,workerAddress);
        salary[workerAddress] =  workerSalary;
        workersBoss[workerAddress] =  bossAddress;
        
    }
    
    function fire(address workerAddress) public payable costs(10 wei){
        require(workersBoss[workerAddress] == msg.sender);
        deletePerson(workerAddress);
    }
}