pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      address addr;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    Person[] private people;
    mapping (address=>uint) private userPeopleBalance;
    mapping (address=> uint[] ) private peoplePerUser;
    

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
        people.push(newPerson);
        userPeopleBalance[msg.sender]=userPeopleBalance[msg.sender]+1;
        
        //below we add a new ID to the people array for the user
        peoplePerUser[msg.sender].push(peoplePerUser[msg.sender].length);  
        
    }
    
    function getPerson(uint index) public view returns(address addr, string memory name, uint age, uint height, bool senior,uint numberOfPeople){
        return (people[index].addr,people[index].name, people[index].age, people[index].height, people[index].senior, userPeopleBalance[people[index].addr]);
    }
    
    //Create a function that returns an array of all the ID's that the msg.sender has created.
    function getUserPeopleBalance () public view returns (uint numberOfPeople){
        return userPeopleBalance[msg.sender];
    }
    
    function getPeopleIdPerUser () public view returns (uint[] memory peopleIdsPerUser){
        return peoplePerUser[msg.sender];
    }

}
