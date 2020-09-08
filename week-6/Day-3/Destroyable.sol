pragma solidity 0.5.12;
import './Ownable.sol';

contract Destroyable is Ownable{
    
    function close() public onlyOwner { //onlyOwner is custom modifier
      selfdestruct(address(uint160(owner)));  // `owner` is the owners address
    }
}