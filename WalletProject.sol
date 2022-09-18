// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.15;

 contract Wallet {
//this wallet can send and receive eth
//can also track the transactions amount and timestamp
//can send to other user wallets as well as contract addresses

struct transactionRecord {
    uint amount;
    uint timestamp;
    string Ttype;
}
struct accountDetails {
uint balance;
uint numDeposits;
uint numWithdraws;
uint numSends;
uint numReceives;
mapping(uint=>transactionRecord) deposit;
mapping(uint=>transactionRecord) withdraw;
mapping(uint=>transactionRecord) sent;
}
mapping(address=>accountDetails) public myDetails;
transactionRecord public newTransaction;

//function for the wallet to receive the amount
function ReceiveFunds()public payable {
    string memory Stype="Deposit";
    newTransaction=transactionRecord(msg.value,block.timestamp,Stype);
    myDetails[msg.sender].balance+=msg.value;
    myDetails[msg.sender].numDeposits++;
}
//function wallet to withdraw an amount
function withdraw(uint amount) public{
    //first, we need to ensure that the function only works if the balance is greater than amount requested
    require(address(this).balance>=amount,"Not enough in the wallet");
    string memory Stype = "Withdrawal";
    payable(msg.sender).transfer(amount);
    newTransaction=transactionRecord(amount,block.timestamp,Stype);
    myDetails[msg.sender].balance-=amount;
    myDetails[msg.sender].numWithdraws++;

}
//function to send amount to other wallet

function SendTo(address Address, uint Amount) public {
    require(address(this).balance>=Amount,"Not enough in the wallet");
string memory Stype = "Send";
payable(Address).transfer(Amount);
newTransaction=transactionRecord(Amount,block.timestamp,Stype);
  myDetails[msg.sender].balance-=Amount;
    myDetails[msg.sender].numSends++;

    //update receiver account
    myDetails[Address].balance+=Amount;
    myDetails[Address].numReceives++;


}


 }
