//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable {
        owner = msg.sender; // msg sender represents address being called
        fortune = msg.value; //msg value tells us how much ether is being sent  
    }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // only allocate funds if friend's gramps is deceased

    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }    

    // list of family wallets
    address payable[] familyWallets;

    // map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address 
    function setInheritance(address payable wallet, uint amount) public onlyOwner{
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // transferring funds from contract address to reciever address
    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}