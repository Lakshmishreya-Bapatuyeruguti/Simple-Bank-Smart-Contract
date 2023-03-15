// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; 

contract Banking{
    // Mapping address of owner with the balance 
    mapping(address=>uint) public customerBalance;

    // Events 
    event successfulDeposit(address customerAddress, string message);
    event successfulWithdraw(address customerAddress, string message);

    // Function Modifier to check if transaction is possible with available balance
    modifier hasSufficientBalance(uint requestedAmount)  {
        require(requestedAmount<=customerBalance[msg.sender],"You do not have sufficient balance");
        _;
    }

    // Function To deposit
    function depositFunds()public payable {
        customerBalance[msg.sender]+=msg.value;
        emit successfulDeposit(msg.sender, "Deposited Succesfully");
    }

    // Function To withdrawal
    function withdraw( uint amount) hasSufficientBalance(amount) public payable{
        customerBalance[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
        emit successfulWithdraw(msg.sender, "Withdrawal done Succesfully");
    }

    // Function to view balances
    function viewBalance() view  public returns(uint){
       return address(this).balance;
    }
} 
