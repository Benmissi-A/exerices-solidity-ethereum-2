// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract Testament{
    
      using Address for address payable;
      
      address private _owner;
      address private _doctor;
      bool private _isDead;
      mapping(address =>uint256) private _balances;
      constructor(address owner_ , address doctor_ ){
        _owner = owner_ ;
        _doctor = doctor_ ;
      }
      
      modifier onlyOwner{
          require(msg.sender == _owner , " you are not the owner");
          _;
      }
      
      modifier onlyDoctor{
          require(msg.sender == _doctor , " you are not the doctor");
          _;
      }
      
      modifier ownerIsDead{
          require(_isDead == true , "the owner is not dead");
          _;
      }
      
      function setDoctor(address doctor_) public onlyOwner {
          _doctor = doctor_ ;
      }
      
      function bequeath(address account, uint256 amount) public payable onlyOwner{
            _balances[account] += amount;
      }
      
      function deathCertificate() public onlyDoctor {
          _isDead = true;
      }
      
     function withdrawHeritage() public payable ownerIsDead {
         uint256 amount = _balances[msg.sender];
         _balances[msg.sender] = 0;
         payable(msg.sender).sendValue(amount);
     }
     
     
    function viewHeritage() public view returns (uint256){
        return _balances[msg.sender];
    }
    
    
      
}