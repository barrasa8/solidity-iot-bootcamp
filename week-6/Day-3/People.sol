pragma solidity 0.5.12;
import './Destroyable.sol';

contract People is Destroyable{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);

    uint public balance;

    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }

    mapping (address => Person) private people;
    address[] private creators;

    function  createPerson(string memory name, uint age, uint height,address personAddress)  internal  {
      require(age < 150, "Age needs to be below 150");
      
      balance += msg.value;

        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        if(age >= 65){
           newPerson.senior = true;
       }
       else{
           newPerson.senior = false;
       }

        insertPerson(newPerson,personAddress);
        creators.push(personAddress);

        assert(
            keccak256(
                abi.encodePacked(
                    people[personAddress].name,
                    people[personAddress].age,
                    people[personAddress].height,
                    people[personAddress].senior
                )
            )
            ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );
        emit personCreated(newPerson.name, newPerson.senior);
    }
    function insertPerson(Person memory newPerson,address personAddress) private {
        address creator = personAddress;
        people[creator] = newPerson;
    }
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    function deletePerson(address creator) public {
      string memory name = people[creator].name;
      bool senior = people[creator].senior;

       delete people[creator];
       assert(people[creator].age == 0);
       emit personDeleted(name, senior, owner);
    }

   function getCreator(uint index) public view onlyOwner returns(address){
       return creators[index];
   }
   function withdrawAll() public onlyOwner returns(uint) {
       uint toTransfer = balance;
       balance = 0;
       msg.sender.transfer(balance);
       return toTransfer;
   }
}