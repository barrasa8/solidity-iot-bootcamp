pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    mapping (address => Person) private people;
    
    event PersonCreated(string name, bool senior);
    event PersonUpdated(string oldName, string newName, uint oldAge, uint newAgne, uint oldHeight, uint newHeight,bool oldSenior, bool newSenior );

    function createPerson(string memory name, uint age, uint height) public {
        require(age<120  && height<230);
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

        insertPerson(newPerson);

        emit PersonCreated(newPerson.name, newPerson.senior);
    }
    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    function updatePersonInfo (string memory name, uint age, uint height) public {
        require(age<120  && height<230);
        Person memory oldPerson = people[msg.sender];
        
        if(bytes(name).length > 0){
           people[msg.sender].name =  name;
           assert( keccak256( abi.encodePacked(people[msg.sender].name)) ==  keccak256( abi.encodePacked(name)));
        }
        
        if(age>0){
           people[msg.sender].age =  age;
           if (age>=65){
               people[msg.sender].senior=true;
           }else{
               people[msg.sender].senior = false;
           }
           assert(people[msg.sender].age ==  age);
        }
        
        if(height>0){
           people[msg.sender].height = height;
           assert(people[msg.sender].height ==  height);
        }
        emit PersonUpdated(oldPerson.name, name, oldPerson.age, age, oldPerson.height,height,oldPerson.senior,people[msg.sender].senior);
    }

}

