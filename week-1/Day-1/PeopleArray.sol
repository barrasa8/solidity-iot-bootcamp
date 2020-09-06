pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      address addr;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    //mapping (address => Person) private people;
    Person[] private people;
    mapping (address=>uint) private peopleBalance;

    function createPerson(string memory name, uint age, uint height) public {
        //This creates a person
        Person memory newPerson;
        newPerson.addr =  msg.sender;
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
    }
    function insertPerson(Person memory newPerson) private {
        //address creator = msg.sender;
        //people[creator] = newPerson;
        people.push(newPerson);
        peopleBalance[msg.sender]=peopleBalance[msg.sender]+1;
    }
    function getPerson(uint index) public view returns(address addr, string memory name, uint age, uint height, bool senior,uint numberOfPeople){
        //address creator = msg.sender;
        return (people[index].addr,people[index].name, people[index].age, people[index].height, people[index].senior, peopleBalance[people[index].addr]);
    }
}