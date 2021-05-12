// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract Birthday{
    
    using Address for address payable;
    
    address private _owner;
    uint256 private _birthday;
    uint256 private _present;
    
      
    constructor(address owner_ , uint256 Birthday_){
        _owner = owner_ ;
        _birthday = Birthday_ ;
    }
      
    modifier onlyOwner{
        require(_owner == msg.sender , "you are not the owner");
        _;
    }
    
    modifier notOwner{
        require(_owner != msg.sender , "everyone can but not you");
        _;
    }
    modifier atBirthday{
        require(_birthday < block.timestamp , "you have not reached your birthday");
        _;
    }
      
      
    receive() external payable {
        _present += msg.value;
    }
      
    // fonction qui permet de deposer des fonds dans le smartContract
    function offer() public payable notOwner{
        _present += msg.value;
    }
      
      
    //fonction qui permet de recuperer les ether dans le smart contract apres le jour d el'anniversaire
    function getPresent() public payable onlyOwner atBirthday{
        uint256 ammount = _present;
        _present = 0;
        payable(_owner).sendValue(ammount);
    }
      
    function viewPresent() public view notOwner returns(uint256){
        return _present;
    }
    
    
    // test functions 
    
    function getTime()public view returns (uint256){
        return block.timestamp ;
    }
    
    function dateIsTrue() public view returns (bool){
        return _birthday <  block.timestamp ? true : false;
    }
    

}